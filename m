From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/29] PM: proposed branch for PM collaboration
Date: Tue, 16 Sep 2008 20:17:41 +0200
Message-ID: <2392409E-3902-40A5-BF17-194FE710C2D2@student.utwente.nl>
References: <87iqt2amoi.fsf@deeprootsystems.com> <48CFB12A.4040001@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-616209745"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:57889 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbYIPSVA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2008 14:21:00 -0400
In-Reply-To: <48CFB12A.4040001@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-616209745
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 16 sep 2008, om 15:14 heeft Kevin Hilman het volgende geschreven:

> Kevin Hilman wrote:
>> Hello,
>> The following patchset is an attempt to collect the various PM  
>> patches
>> that have been flowing around, and organize them into one branch to  
>> be
>> used for further collaboration on PM development, in particular
>> OFF-mode support.
>
> This series has been rebased onto today's OMAP git, and pushed as  
> branch pm-0.
>
> I will now start collecting more recent versions of these patches  
> and newer patches sent to the list for the next version of the branch.

What are your plans for including the omap3 cpufreq patchset?

regards,

Koen


>
>
> Kevin
>
>> It is currently a collection of proposed patches[1] from TI and
>> various other patches from Nokia and others to get retention,
>> OFF-mode, CPUidle etc. working in the linux-omap tree.
>> This series is nowhere near ready for merging into linux-omap, but
>> will be useful for discussion and collaboration on getting the  
>> various
>> PM features working at the head of the linux-omap tree, and a place
>> where cleanup and rework efforts can be focused.  If there are no  
>> major objections, I will create a branch in linux-omap
>> git and commit this series there.  As collaboration continues, I will
>> continue to collect and update patches, fix problems and rebase onto
>> the HEAD of linux-omap.  The goal of this branch is only to  
>> facilitate the rework and cleanup
>> of the PM code so it can be merged into linux-omap.  Then, the branch
>> will disappear and work can be focused again on the HEAD of
>> linux-omap.
>> It has currently been tested with a minimal config on 3430SDP, and
>> OFF-mode is hit in suspend.  In order to hit suspend:
>>  echo 1 > /sys/power/voltage_off_while_idle                      
>> echo 1 > /sys/power/gpio_clocks_off_while_idle                 echo  
>> 1 > /sys/power/uart_clocks_off_while_idle   echo mem > /sys/power/ 
>> state
>> Kevin
>> [1] This series is roughly based on the following:
>> Jouni Hogander, Tero Kristo
>> [PATCH 0/4] Refreshed PM workaround patches 2 -- 15 Aug
>> Rajendra Nayak:
>> [PATCH 00/11] OMAP3 CPUidle patches - ver 2 -- 18 July
>> As well as several patches/hacks/cleanups that have not yet been
>> posted to the list.
>> Also, there have been newer versions of the CPUidle patches that have
>> been reviewed on the list, but do not apply for various reasons.  As
>> soon as they are rebased and updated versions of those are available,
>> I will integrate them.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-2-616209745
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIz/hHMkyGM64RGpERAoNQAJ4sSSCXPMwIum3NzU8QbxAze2S1PwCgrT69
TJPDYmUx1+dJmhqGpJuLkg4=
=3jjM
-----END PGP SIGNATURE-----

--Apple-Mail-2-616209745--
