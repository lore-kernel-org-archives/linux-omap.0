From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource structure
Date: Tue, 28 Sep 2010 17:42:04 -0400
Message-ID: <AANLkTi=UpeYtuQDuxEt2FNSajB-rtMpMZwseD=GUao2Y@mail.gmail.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com>
 <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8@mail.gmail.com> <alpine.DEB.2.00.1009281515590.5439@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47894 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab0I1VmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:42:25 -0400
In-Reply-To: <alpine.DEB.2.00.1009281515590.5439@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Tue, Sep 28, 2010 at 17:18, Paul Walmsley wrote:
> On Tue, 28 Sep 2010, Mike Frysinger wrote:
>> well, currently, your resource definition must always be in the orde=
r
>> of dev int and then dma int. =C2=A0if it isnt, then i dont think mus=
b is
>> going to work.
>>
>> not sure why you wouldnt simply change your platform resources to
>> match the what the driver expects ...
>
> The resource data is getting automatically populated from a set of da=
ta
> generated from TI's hardware database for the OMAP platform, at least=
=2E
> While we could hack in some exceptions to that tool to generate resou=
rces
> in a specific order, it seems less fragile to use the resource name
> instead. =C2=A0That way, no matter what order the resources are gener=
ated, the
> driver should still work.

guessing you're not referring to a device tree setup, but something
even more convoluted ?

i'd highly suggest that this patch be resent with the info you've just
provided in its changelog so people can get a better understanding of
the "why" ... i'm not against the patch, it just seemed to be lacking
any background info
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
