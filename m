From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: RFC: bq2415x_charger driver
Date: Wed, 07 Dec 2011 23:25:12 +0200
Message-ID: <4EDFD9B8.1050300@mleia.com>
References: <1323124541-7590-1-git-send-email-felipe.contreras@nokia.com> <1677656.4d3iQHNZjX@pali-elitebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1677656.4d3iQHNZjX@pali-elitebook>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Aliaksei Katovich <aliaksei.katovich@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Joerg Reisenweber <joerg@openmoko.org>
List-Id: linux-omap@vger.kernel.org

Hi Pali,

On 07.12.2011 23:03, Pali Roh=C3=A1r wrote:
> Hello,
>
> I'm sending preview of my implementation of bq2415x charger driver. N=
ow all
> code is in one kernel module bq2415x_charger which has more interface=
s
> (power_supply, sysfs, regulator). It is still unfinished, missing mor=
e bq2415x
> configuration like sysfs entires for boost, voltages or platform hook=
s (e.g.
> rx51 isp1704). This driver will have similar sysfs interface as in Jo=
erg
> Reisenweber spec http://maemo.cloud-7.de/bq24150-sysnode.spec.txt . D=
river
> should be replacemnt for Nokia N900 proprietary charging program BME.=
 I was
> inspirated by driver bq27x00_battery and other bq2415x implementaton =
by
> Aliaksei Katovich and Felipe Contreras.
>
> Please comment implementation and write what should be added or modif=
ied in
> driver (it is still not complete).
>

There are well defined policies regarding patch review in the Linux=20
kernel mailing lists. I encourage you to take a look at=20
http://felipec.wordpress.com/2009/10/25/git-send-email-tricks/

--=20
With best wishes,
Vladimir
