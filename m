From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Tue, 23 Nov 2010 10:10:48 +0200
Message-ID: <20101123081048.GJ2729@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
 <4CE5B68F.8000502@ti.com>
 <AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
 <20101119083250.GH6446@legolas.emea.dhcp.ti.com>
 <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
 <4CE68E9A.5040903@ti.com>
 <20101122100815.GM2446@legolas.emea.dhcp.ti.com>
 <4CEA8473.3040404@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:48628 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734Ab0KWIKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 03:10:42 -0500
Received: by mail-yx0-f169.google.com with SMTP id 31so2039794yxl.14
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 00:10:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CEA8473.3040404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 22, 2010 at 03:55:47PM +0100, Cousson, Benoit wrote:
>So far we are using a artificial SW IP revision that reflect the 
>difference we'd like to highlight v1, v2.

but what's the big deal in reading that from HW itself ? The only change
will in the comparisson operator. Instead of doing:

if (rev == REV_V1)

you'll be doing:

if (rev >= REV_V1_X_Y_Z)

no ??

-- 
balbi
