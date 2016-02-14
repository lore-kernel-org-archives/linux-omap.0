From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] MAINTAINERS: Add co-maintainer for remoteproc subsystems
Date: Sat, 13 Feb 2016 17:35:19 -0800
Message-ID: <1455413719-22412-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

Add myself as co-maintainer for the remote processor related subsystems,
as agreed with Ohad.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ebe2e886d36..f51056b02fcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4989,6 +4989,7 @@ F:	include/linux/hw_random.h
 
 HARDWARE SPINLOCK CORE
 M:	Ohad Ben-Cohen <ohad@wizery.com>
+M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
 F:	Documentation/hwspinlock.txt
@@ -9170,6 +9171,7 @@ F:	include/linux/regmap.h
 
 REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
 M:	Ohad Ben-Cohen <ohad@wizery.com>
+M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
 S:	Maintained
 F:	drivers/remoteproc/
@@ -9178,6 +9180,7 @@ F:	include/linux/remoteproc.h
 
 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
 M:	Ohad Ben-Cohen <ohad@wizery.com>
+M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
 S:	Maintained
 F:	drivers/rpmsg/
-- 
2.5.0
