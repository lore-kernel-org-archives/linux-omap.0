From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Request for OMAPDSS testing
Date: Sun, 16 Jun 2013 15:28:26 +0300
Message-ID: <51BDAF6A.1020102@compulab.co.il>
References: <51AD99F5.7060506@ti.com> <51B9EA7B.8070906@compulab.co.il> <51B9ECBE.3010401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:37787 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069Ab3FPM2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jun 2013 08:28:40 -0400
In-Reply-To: <51B9ECBE.3010401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 06/13/13 19:01, Tomi Valkeinen wrote:
> On 13/06/13 18:51, Igor Grinberg wrote:
>> Hi Tomi,
>>
>> On 06/04/13 10:40, Tomi Valkeinen wrote:
>>> Hi guys,
>>
>>> I've made some big changes on the omapdss device model, which involves
>>> converting all the panel drivers. I've got only a bunch of boards, so I
>>> hope some of you can perhaps do some minimal tests on some other boards.
>>
>>> I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.
>>
>>> The code can be found from the below git branch. It's based on 3.10-rc1.
>>
>>> git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
>>
>> Works on cm-t3730.
>> Tested with tdo24m LCD and DVI.
> 
> Thanks!
> 
>> Although one thing is missing from the tfp410 driver is
>> the PD GPIO polarity. I had to adjust it locally to get the DVI working.
>> The original polarity was high = disabled, low = enabled.
> 
> Hmm, but this is missing from the old driver also, isn't it? At least
> with a quick glance the old and new tfp410 drivers do the same thing
> with the PD gpio.

Well, we were driving the PD GPIO from the board file...


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRva9qAAoJEBDE8YO64EfayBcP/iE1iVjdcYgf6SCw7IyrXHpC
CUEroVpfQiLP8MwJ/ZNuGWwsFWbrD+Q8j5vSLJapjn1QPD3VEH830FXfWNzxxvhD
ZWk5C3rsXy9q7FWonHixpbdPQnEptCBKkHqgpVPuLTaywC2h2jUxZoVLmBhbSoBo
TQG210CxxE18qK+ztolxScA4ZlYwOAUPSNNJ2zE9UGI2n/8UrW9y0PJLluM2cAOd
odlEuDNGmVmkbPsnRTI52r8IqhprrWC7S+5J1rsprJylgrudQXW0cSKJ7wi2bxy4
JWJd3C+pD7ocyRp76pm/kXD6NSAgrhqqHnbXK82DDlJvewAUOlF23iOIiXnsEDIY
Uui4EvGVrzQl0Pe8eIxRIZzhJ2n7ryZ7360w0xiKc++X3s34kJ/mATlQi8Sm4Ve/
gbIqJRirdsvTDbxSwUOTX14qJvkZBvPA6Os1qSXmLsF7/DDUf3OreWL7JksKuxlI
1sGtvS7Y7IP7Wyr4PcEC6cb8Dy6GLT0o5GZWSC/VIPwHl+MlZMsMz4sp9AbuDrjQ
TsoBmPpGi2/1i9+aCIeTzzgK9dZ320PlEYClXXvWOlG9YRqD01PIfhm4YfbCw0Dc
/wr5mjTxkCvtcYY2uSbW0+xlBFNwPFinRGw+tXv5q/6xjh27BNmyVNLlvGawcKgc
NrkwMGcNV0txD8TFhnEh
=IxQT
-----END PGP SIGNATURE-----
