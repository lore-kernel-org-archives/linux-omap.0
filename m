From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] twl4030-madc: Fix arbitrarily initialized function pointer
Date: Wed, 02 Jul 2008 08:54:45 -0500
Message-ID: <f30014d3264cbcef10a9f0342fce7ac2@felipebalbi.com>
References: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com> <1215005796-10117-2-git-send-email-viktor.rosendahl@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60322 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYGBNyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 09:54:50 -0400
In-Reply-To: <1215005796-10117-2-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Cc: linux-omap@vger.kernel.org



On Wed,  2 Jul 2008 16:36:36 +0300, Viktor Rosendahl
<viktor.rosendahl@nokia.com> wrote:
> req is an automatic variable and thus we cannot rely on it being
> initialized to
> zero (I am leaving the 0!= NULL discussion aside). Other functions test
> if this pointer is NULL, in order to determine whether it is a valid
> address or
> not.


> +		req.func_cb	= NULL;

maybe below is a better patch:

diff --git a/drivers/i2c/chips/twl4030-madc.c
b/drivers/i2c/chips/twl4030-madc.c
index 72b126b..6d8915e 100644
--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -360,7 +360,7 @@ static int twl4030_madc_ioctl(struct inode *inode,
struct file *filp,
 
        switch (cmd) {
        case TWL4030_MADC_IOCX_ADC_RAW_READ: {
-               struct twl4030_madc_request req;
+               static struct twl4030_madc_request req;
                if (par.channel >= TWL4030_MADC_MAX_CHANNELS)
                        return -EINVAL;
-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

