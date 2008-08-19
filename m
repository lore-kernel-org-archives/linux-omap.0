From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Tue, 19 Aug 2008 21:46:00 +0000 (UTC)
Message-ID: <g8feuo$i9$1@ger.gmane.org>
References: <1216221555-18958-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758868AbYHSVqW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:

> Hi all,
> 
> This patch series contains power domain and clock domain specific
> patches for omap posted to linux-arm-kernel list during 2.6.25-rc5.
> 
> I'm reposting the series to a wider audience as Russell King suspected
> that other archs may be interested in reviewing these too, or at least
> some parts of the code.
> 
> Please take a look and comment the code. Also please point out the
> pieces of code that may be suitable for your arch too!

There is one major flaw IMO in this code. Please correct me if I'm wrong:
Driver A: powerdomain_register()
Driver B: powerdomain_get()
Driver A: powerdomain_unregister()

Then Driver B has a reference to unregistered domain. And as powerdomains
lack any type of refcounting this can lead to any type of memory access
bugs if Driver A is unloaded from the kernel.

-- 
With best wishes
Dmitry
