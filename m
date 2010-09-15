From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in musb_g_tx
Date: Wed, 15 Sep 2010 19:14:41 +0800
Message-ID: <AANLkTi=m0UTDnX9HFAuEPrm_7hbZW=CzeV=juXrj+wiC@mail.gmail.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
	<20100915105641.GO3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100915105641.GO3393@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

2010/9/15 Felipe Balbi <balbi@ti.com>:

>
>> IMO, it is not difficult to give a good fix for the ZLP problem
>> if the two questions are clear.
>
> true, but some re-work needs to be done.

I suggest we do the fix for ZLP issue in a new patch against the
current patch set to avoid the rework. More importantly, it is one
another fix, we should insist on the rule: do one fix in one commit,
which is very helpful to do version management(regression test,
bisect...).

-- 
Lei Ming
