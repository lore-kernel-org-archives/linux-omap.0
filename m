From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM Issues after Android bootup on 2430
Date: Fri, 2 May 2008 08:52:07 +0200
Message-ID: <7ACFA832-E2A9-4691-8FBE-9A418BD8E3D7@student.utwente.nl>
References: <70E3BF80B2DA6E469688AD5C3BBCC6C40365F3B7@BLR-EC-MBX02.wipro.com> <782515bb0804291818w2296bdcajc026f3ab6e6af96a@mail.gmail.com> <87d4o5elx0.fsf@paris.hilman.org> <0680EC522D0CC943BC586913CF3768C001578E7762@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45900 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667AbYEBGwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 May 2008 02:52:32 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C001578E7762@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 2 mei 2008, om 05:46 heeft Syed Mohammed, Khasim het volgende  
geschreven:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, May 02, 2008 3:18 AM
>> To: Nishanth Menon
>> Cc: shivananda.hebbarp@wipro.com; linux-omap@vger.kernel.org
>> Subject: Re: PM Issues after Android bootup on 2430
>>
>> "Nishanth Menon" <menon.nishanth@gmail.com> writes:
>>
>>> On 4/29/08, shivananda.hebbarp@wipro.com <shivananda.hebbarp@wipro.com 
>>> >
>> wrote:
>>>> omapfb omapfb: irq error status 00e2
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>>> omapfb omapfb: irq error status 0040
>>> This does look suspiciously like the thread
>>> http://linux.omap.com/pipermail/linux-omap-open-source/2007-
>> July/010566.html
>>>
>>> Interesting... ;)... I never got the chance to debug this issue..
>>>
>>> Kevin, Khasim, did u guys get a chance to look at this later?? I  
>>> dont
>>> recollect hearing any one saying the same for 3430 though..
>>
>> No, I never debugged this any further.  AFAIK, the omapfb is still
>> broken in git.
>>
> Me too :(.
>
> We have FB working for 3530 EVM / Beagle boards. Should be same for  
> 2430/2530 as well.


against git or 2.6.22?

regards,

KOen

>
>
> Regards,
> Khasim
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIGroaMkyGM64RGpERAoJfAJ9CRdM/Bo7qmM4qoe3YO70ALcU8sgCfVoqi
1mC/iHb196xeHblIunXDBEQ=
=HR7R
-----END PGP SIGNATURE-----
