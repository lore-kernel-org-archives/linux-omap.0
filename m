From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in musb_g_tx
Date: Thu, 16 Sep 2010 14:54:57 +0800
Message-ID: <AANLkTi=bk5eEKb3RtzwOk7QCV+EtumvSc=zmXYuzpPFO@mail.gmail.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
	<20100915105641.GO3393@legolas.emea.dhcp.ti.com>
	<AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com>
	<20100915110745.GP3393@legolas.emea.dhcp.ti.com>
	<4C90C5B7.7050103@ru.mvista.com>
	<20100916060520.GA3393@legolas.emea.dhcp.ti.com>
	<AANLkTi=y-HfvDOvhW-WhLFq5TUCjGA-52cuyByCHMvvV@mail.gmail.com>
	<20100916062232.GC3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100916062232.GC3393@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

2010/9/16 Felipe Balbi <balbi@ti.com>:

>> If it's TX, both condtions should automatically be true, right?
>
> even in mode1 ? I have to revist my docs, but afaict mode1 won't
> transmit last short packet, no matter if it's tx or rx. Could be wrong,
> though.

Seems short packet is always sent using mode 0, see txstate.

-- 
Lei Ming
