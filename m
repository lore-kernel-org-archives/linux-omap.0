From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 13:52:51 +0300
Message-ID: <20100915105251.GN3393@legolas.emea.dhcp.ti.com>
References: <20100915065345.GC3393@legolas.emea.dhcp.ti.com>
 <4C909961.10001@ru.mvista.com>
 <20100915100553.GJ3393@legolas.emea.dhcp.ti.com>
 <4C909B2E.3000909@ru.mvista.com>
 <AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com>
 <4C909D87.2090901@ru.mvista.com>
 <20100915102256.GK3393@legolas.emea.dhcp.ti.com>
 <4C909F99.9050300@mvista.com>
 <20100915103152.GM3393@legolas.emea.dhcp.ti.com>
 <4C90A2E3.9020300@mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C90A2E3.9020300@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 15, 2010 at 05:41:39AM -0500, Sergei Shtylyov wrote:
>> your forgetting the fact that not always you need to send ZLP after
>> completing a packet_size-aligned transfer,
>
>    So what?

what you're saying is that when we change the ZLP handling, the
request->actual == request->lenght check will have to be removed, but
that's not true because ZLP is only needed if request->zero is set.

So the final code would be something like (pseudo-code):

if (request->lenght % musb_ep->packet_sz)
	set_last_packet_is_short_flag(musb_request);

if (request->zero || last_packet_is_short(request)) {
	set_txpktrdy(musb);
	set_musb_request_completed_flag(musb_request);
	return;
}

if (request->acual == request->length)
	musb_g_giveback(musb, request);

restart_ep_if_more_requests(musb_ep);


> > ok, but I don't.
>
>    Well, you're the maintainer.

the thing is that this discussion is preventing me from sending me the
other 10 patches to Greg. So either we drop it now and send the exact
same patch (or a similar version) for next -rc or I send them all now.
Since I'm not seeing the problem you're describing I'm more inclined to
send them all.

-- 
balbi
