From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: OMAP 730 audio driver
Date: Thu, 17 May 2007 21:22:06 -0500
Message-ID: <464D0DCE.7090206@gmail.com>
References: <61445c750705170728ubbf884cn1b34df8f196834ea@mail.gmail.com>
	<200705171732.04024.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200705171732.04024.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> Dne =C4=8Dtvrtek 17 kv=C4=9Bten 2007 16:28 Pharaoh . napsal(a):
>  =20
>> So, the question:
>> 1. Do I need to migrate these drivers to be ALSA compliant?
>>    =20
ALSA is better
>> 2. Has anyone written ALSA drivers for the above mentioned board? Any
>> pointers will be helpful regarding the same.
>>    =20
What is the codec? either AIC/TSC2101 you should be able to find
readymade for omap -h2 onwards..
Regards,
Nishanth Menon
