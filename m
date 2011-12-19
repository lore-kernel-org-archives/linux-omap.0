From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Mon, 19 Dec 2011 22:20:09 +0200
Message-ID: <CAMP44s2pbLRHB2ko9t-zQEpTFw=TaCS9b_qRmvAobgxeJ9WrCw@mail.gmail.com>
References: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
	<1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
	<20111219081137.GF3146@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111219081137.GF3146@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 19, 2011 at 10:11 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 16, 2011 at 01:05:08AM +0200, Felipe Contreras wrote:
>> Properly call pm_runtime_put() afer pm_runttime_get() on errors.
>>
>> Untested.
>
> sorry, but I'm not applying untested patches. I need someone to give a
> Tested-by.

I'm pretty sure most people don't test the exit paths, but fine, don't
apply them. Who needs power management anyway.

-- 
Felipe Contreras
