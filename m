From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: OMAP support in mainline?
Date: Fri, 19 Sep 2008 16:57:44 -0400
Message-ID: <1f11a5490809191357v144f969jb93b6cd5022db4d4@mail.gmail.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com>
	 <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
	 <200809162255.00918.david-b@pacbell.net>
	 <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl>
	 <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
	 <48D3F921.8020306@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:2789 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYISU5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 16:57:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so611948rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 13:57:44 -0700 (PDT)
In-Reply-To: <48D3F921.8020306@balister.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 19, 2008 at 3:10 PM, Philip Balister <philip@balister.org> wrote:
> Steve Sakoman wrote:
>>
>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente.nl>
>> wrote:
>>
>>> And they aren't working too well with current l-o git either with MUSB
>>> being
>>> broken. There's a patch to fix client mode, but host mode still isn't
>>> working.
>>
>> Host mode musb is working just fine on Overo with the "set
>> transceiver" patch.  Not sure why you are having trouble with Beagle
>> (and can't check since I don't have my Beagle board with me at the
>> moment)
>
> Does anyone have any suggestions how to figure out what is broken about OTG
> used a host on the Beagle?
>
> Philip
>

On a related point..I built Kernel v.2.6.27-rc3 from the OMAPZOOM tree
with MUSB OTG support. I plug in the mini-B connector into our board,
and I get the interrupt and proper recognition that a peripheral mode
should be used. When the mini-A connector is plugged in, however,
nothing happens.

Since there is only one interrupt that triggers the check on which
cable-type was plugged in, why would the mini-A cable not cause an
interrupt to be generated?

I've also tried compiling the code in just MUSB HOST. Nothing happens,
when I plug in the mini-B cable, it's detected by markedly less things
happen because I don't have peripheral support.

Regards
~ Ashwin
