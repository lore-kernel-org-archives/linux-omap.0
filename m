From: Pavel Machek <pavel@ucw.cz>
Subject: -n900 (not mainline): fix compilation with 3.20-rc0
Date: Wed, 11 Feb 2015 23:23:42 +0100
Message-ID: <20150211222342.GE11313@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org


commit 02aa41563bd0f14268d2142ab69694880d3425a1
Author: Pavel <pavel@ucw.cz>
Date:   Wed Feb 11 23:22:51 2015 +0100

    Fix compilation of wl1251 specific parts with 3.20-rc0.
    
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/net/wireless/ti/wl1251/netlink.c b/drivers/net/wireless/ti/wl1251/netlink.c
index e5f5a45..90a5486 100644
--- a/drivers/net/wireless/ti/wl1251/netlink.c
+++ b/drivers/net/wireless/ti/wl1251/netlink.c
@@ -190,11 +190,7 @@ static int wl1251_nl_test_cmd(struct sk_buff *skb, struct genl_info *info)
 			sizeof(*cmd), cmd))
 			goto nla_put_failure;
 
-		ret = genlmsg_end(msg, hdr);
-		if (ret < 0) {
-			wl1251_error("%s() failed", __func__);
-			goto nla_put_failure;
-		}
+		genlmsg_end(msg, hdr);
 
 		wl1251_debug(DEBUG_NETLINK, "TEST cmd sent, answer");
 		ret = genlmsg_reply(msg, info);
@@ -270,11 +266,7 @@ static int wl1251_nl_interrogate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_put(msg, WL1251_NL_ATTR_CMD_IE_ANSWER, cmd_ie_len, cmd))
 		goto nla_put_failure;
 
-	ret = genlmsg_end(msg, hdr);
-	if (ret < 0) {
-		wl1251_error("%s() failed", __func__);
-		goto nla_put_failure;
-	}
+	genlmsg_end(msg, hdr);
 
 	kfree(cmd);
 	return genlmsg_reply(msg, info);
@@ -406,14 +398,10 @@ static int wl1251_nl_phy_reg_read(struct sk_buff *skb, struct genl_info *info)
 	if (nla_put_u32(msg, WL1251_NL_ATTR_REG_VAL, *reg_value))
 		goto nla_put_failure;
 
-	ret = genlmsg_end(msg, hdr);
-	if (ret < 0) {
-		wl1251_error("%s() failed", __func__);
-		goto nla_put_failure;
-	}
+	genlmsg_end(msg, hdr);
 
 	kfree(reg_value);
-
+	
 	return genlmsg_reply(msg, info);
 
 nla_put_failure:
@@ -509,11 +497,7 @@ static int wl1251_nl_reg_read(struct sk_buff *skb, struct genl_info *info)
 	if (nla_put_u32(msg, WL1251_NL_ATTR_REG_VAL, val))
 		goto nla_put_failure;
 
-	ret = genlmsg_end(msg, hdr);
-	if (ret < 0) {
-		wl1251_error("%s() failed", __func__);
-		goto nla_put_failure;
-	}
+	genlmsg_end(msg, hdr);
 
 	return genlmsg_reply(msg, info);
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
