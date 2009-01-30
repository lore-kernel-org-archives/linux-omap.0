From: Koen Kooi <koen@beagleboard.org>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 23:09:13 +0100
Message-ID: <212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com> <87zlhbqtrv.fsf@deeprootsystems.com> <87skn3qq6x.fsf@deeprootsystems.com> <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org> <13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--504400544"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:46892 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZA3WJV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 17:09:21 -0500
Received: by ewy14 with SMTP id 14so1004919ewy.13
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 14:09:18 -0800 (PST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2--504400544
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 30 jan 2009, om 23:03 heeft Woodruff, Richard het volgende  
geschreven:

>
>>> Just a thought, do you still see these problems when using the  
>>> CPUfreq
>>> performance governor instead of the ondemand governor?
>>>
>>> It could be pointing to some bugs in the switching of operating
>>> points.
>>
>> Speaking of operating points, is there a reason why cpufreq only goes
>> to 550MHz? It's disappointing that omap3 gets marketed with "600MHz",
>> but that TI won't let it run at that speed with their cpufreq  
>> drivers.
>
> Run at that speed on your board if you like.  You can run even  
> faster if you like but at some point you will start to have odd  
> failures.
>
> The 600MHz overdrive operating point is such that if you use it all  
> the time your part life may be reduced.  If you use the stock  
> ondemand governor with no kind of policy teak you'll be at that OPP  
> a lot.
>
> Percentage operation in overdrive figures into expected life of a  
> given part. For reference code we just make the needed use cases  
> explicitly ask for overdrive.  This way usage is predictable in well  
> defined mobile product.
>
> Depending on the chip you buy things are rated differently.  This  
> rating requires part sorting which typically pushes the price up  
> some.  Any step you add into fabrication of high volumes increases  
> cost.

If you look at http://beagleboard.org/hardware it says "600Mhz"  
multiple times, so I'd expect the board to be running at 600MHz if I  
were a customer. If I read the TRM right I can run the cpu at 600MHz  
continuously for a few years, which exceeds the lifespan of most  
mobile products I have owned.
So my real question is: why limit it in the kernel if all that's  
needed is a costum userspace governer?

regards,

Koen



--Apple-Mail-2--504400544
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJg3qLMkyGM64RGpERAuFcAJ9SN7TCPjU06V2u/jpm9XWQswB2MwCgrG90
1xkcJGdpgCxZQfBl9JGlITY=
=pEca
-----END PGP SIGNATURE-----

--Apple-Mail-2--504400544--
