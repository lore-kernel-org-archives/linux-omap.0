From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: omap: Update bindings for TI
 K3 SoCs
Date: Mon, 8 Jul 2019 16:54:34 -0600
Message-ID: <20190708225434.GA24701@bogus>
References: <20190604170146.12205-1-s-anna@ti.com>
 <20190604170146.12205-2-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604170146.12205-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 4 Jun 2019 12:01:45 -0500, Suman Anna wrote:
> The TI K3 AM65x and J721E family of SoCs have a new Mailbox IP that
> is based on the existing Mailbox IP present in OMAP architecture based
> SoCs. Update the existing OMAP Mailbox bindings for this new IP present
> on TI K3 AM65x and J721E SoCs. The same compatible from AM65x SoCs is
> reused for J721E SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../bindings/mailbox/omap-mailbox.txt         | 59 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
