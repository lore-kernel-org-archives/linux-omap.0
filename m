From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/3] delete unneeded of_node_put
Date: Mon, 12 Oct 2015 22:43:13 +0200
Message-ID: <1444682596-3065-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

Device node iterators perform an of_node_put on each iteration, so putting
an of_node_put before going around to the next iteration results in a
double put.

The complete semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@r exists@
expression e1,e2;
local idexpression n;
iterator name for_each_node_by_name, for_each_node_by_type,
for_each_compatible_node, for_each_matching_node,
for_each_matching_node_and_match, for_each_child_of_node,
for_each_available_child_of_node, for_each_node_with_property;
iterator i;
position p1,p2;
statement S;
@@

(
(
for_each_node_by_name(n,e1) S
|
for_each_node_by_type(n,e1) S
|
for_each_compatible_node(n,e1,e2) S
|
for_each_matching_node(n,e1) S
|
for_each_matching_node_and_match(n,e1,e2) S
|
for_each_child_of_node(e1,n) S
|
for_each_available_child_of_node(e1,n) S
|
for_each_node_with_property(n,e1) S
)
&
i@p1(...) {
   ... when != of_node_get(n)
       when any
   of_node_put@p2(n);
   ... when any
}
)

@s exists@
local idexpression r.n;
statement S;
position r.p1,r.p2;
iterator i;
@@

 of_node_put@p2(n);
 ... when any
 i@p1(..., n, ...)
 S

@depends on s@
local idexpression n;
position r.p2;
@@

- of_node_put@p2(n);
// </smpl>

---

 arch/arm/mach-exynos/pm_domains.c                 |    8 +++-----
 drivers/soc/qcom/smd.c                            |    4 +---
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |    4 +---
 3 files changed, 5 insertions(+), 11 deletions(-)
