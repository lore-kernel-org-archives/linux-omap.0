From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] BUILD FIX:hwspinlock: do not return any value from void funtion
Date: Mon, 7 Nov 2011 15:55:08 +0200
Message-ID: <CAK=WgbZyAEf_x3acGVf=7hPkrHGjg8LdP5ko2Hp_QZoebkhw=Q@mail.gmail.com>
References: <1320670686-29286-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58509 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1KGNz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 08:55:29 -0500
Received: by ywf7 with SMTP id 7so5276256ywf.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 05:55:29 -0800 (PST)
In-Reply-To: <1320670686-29286-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Mon, Nov 7, 2011 at 2:58 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> Fixes below compilation error -

Thanks. We already have this fix queued up though (reported by Axel awhile ago).
