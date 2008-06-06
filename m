From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Fri, 6 Jun 2008 13:01:27 +0200
Message-ID: <831D4C4D-84B0-4B44-A701-1113D17231D0@student.utwente.nl>
References: <1212406192.32058.18.camel@kj-ubuntu> <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl> <B85A65D85D7EB246BE421B3FB0FBB593011132AD90@dbde02.ent.ti.com> <1212472944.32058.31.camel@kj-ubuntu> <B85A65D85D7EB246BE421B3FB0FBB593011132B103@dbde02.ent.ti.com> <20080603151044.GB6992@atomide.com> <1212745780.17269.56.camel@kj-ubuntu>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45668 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbYFFLBw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jun 2008 07:01:52 -0400
In-Reply-To: <1212745780.17269.56.camel@kj-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Beagle Board <beagleboard@googlegroups.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 6 jun 2008, om 11:49 heeft Kalle Jokiniemi het volgende geschreven:

> Hi,
>
>>> Tony, I can update this patch set, or send an additional patch  
>>> that adds
>>> the efuse support. Which will you prefer?
>>
>> Well I guess updating it would be better if it's just defining them  
>> so
>> we have a working patch rather than patch and fix cycle.
>
> It took a bit longer than I expected, but here's the updated
> smartreflex driver that uses the E-fuse values. Thanks to Pratheesh  
> for
> helping out with the details of the implementation.
>
> First patch remains as it was. Some new register and regbit defs have
> been added to the second patch and the last patch now implements the
> E-fuse parameters.

On my beagleboard:

root@beagleboard:/sys/power# echo -n 1 > /sys/power/sr_vdd1_autocomp
OPP3 doesn't support SmartReflex
SR1: VDD autocomp not activated
root@beagleboard:/sys/power#
root@beagleboard:/sys/power# echo -n 1 > /sys/power/sr_vdd2_autocomp
OPP3 doesn't support SmartReflex
SR2: VDD autocomp not activated
root@beagleboard:/sys/power#

The board doesn't crash anymore :)

regards,

Koen



>
>
> I also left in the software hard coded values under a "Smartreflex
> testing support" entry in the Kconfig. For testing purposes only.
>
> Again, tested on 3430SDP.
>
> Regards,
> Kalle
>
>>
>> Regards,
>>
>> Tony
>>
>>
>>
>>
>>>
>>>
>>> Regards,
>>> Kalle
>>>
>>>
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org 
>>>> ] On Behalf Of Koen Kooi
>>>> Sent: Monday, June 02, 2008 6:02 PM
>>>> To: Kalle Jokiniemi
>>>> Cc: linux-omap
>>>> Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
>>>>
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>>
>>>> Op 2 jun 2008, om 13:29 heeft Kalle Jokiniemi het volgende  
>>>> geschreven:
>>>>
>>>>> Here is an updated version of the SmartReflex driver.
>>>>>
>>>>> Patches 1 and 2 are same as before, but patch 3 has some new  
>>>>> things:
>>>>>
>>>>> - Changed the register accessing to use the  
>>>>> prm_xxx_mod_reg{_bits}()
>>>>> functions.
>>>>>
>>>>> - Created a Kconfig entry for SmartReflex in "System type->TI OMAP
>>>>> Implementations" menu.
>>>>>
>>>>> Tested on 3430SDP.
>>>>
>>>> Compiles for beagleboard, but the board hangs after:
>>>>
>>>> echo -n 1 > /sys/power/sr_vdd1_autocomp
>>>> echo -n 1 > /sys/power/sr_vdd2_autocomp
>>>>
>>>> But that's likely to be a beagleboard specific problem.
>>>>
>>>> regards,
>>>>
>>>> Koen
>>>> -----BEGIN PGP SIGNATURE-----
>>>> Version: GnuPG v1.4.5 (Darwin)
>>>>
>>>> iD8DBQFIQ+g/MkyGM64RGpERAqwgAJ97AE4z0bIBZJs7nZcO1Npa8YkIcgCfY6KM
>>>> 3Hhr4AIdmzNiozdqs1uQUgg=
>>>> =rcQP
>>>> -----END PGP SIGNATURE-----
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux- 
>>>> omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux- 
>>> omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFISRkJMkyGM64RGpERAqdKAJ9FPOr/tYcEO17LkM8Ku8fdsD1AuwCgjDwa
L3YD0guaALhLrntQ05vXwKc=
=vkoy
-----END PGP SIGNATURE-----
