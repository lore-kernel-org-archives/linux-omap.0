From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap 0/4] twl4030 regulator support
Date: Tue, 11 Nov 2008 17:56:20 -0800
Message-ID: <200811111756.20719.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:48660 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750956AbYKLCKV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 21:10:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On the grounds that it's probably the way to go, here's initial
support for the regulator framework.

 - simplified TWL child creation code ... updates an earlier
	patch, AFAICT this is ready to merge now
 - regulator driver support ... core functionality seems done
 - create regulator devices ... ditto
 - hook it up for testing ... NOT FOR MERGING

This is a trifle awkward for me to test without test points
to measure the dozen or so LDO regulators that are exposed.
But poking at the registers tells sensible stories, and the
regulator driver code and device setup seem to be in more
or less usable shape ... so it's time to circulate this code!

If this checks out, the first three patches should merge
and then stuff like USB (easiest) and HSMMC can start to
use it.


It's my expectation that virtually no-one on this list will
ever have used the regulator framework before; it's very new,
and the regulator drivers in the mainline kernel aren't for
chips that get much use with current OMAP boards.

So my advice to anyone wanting to switch TWL LDOs on/off is
to allocate an hour or two to play around with the sysfs
interfaces you'll get by applying all four patches and then
booting the resulting kernel:

  /sys/class/regulator/regulator.*/...
	a dozen regulators, most attributes useless (see [1],
	especially [2], and maybe [3] for optional patches
	to improve utility); all are read-only
  /sys/devices/platform/reg-virt-consumer.*
	half as many regulators (platform_bus bug), but
	with WRITABLE attributes for testing with

The "virtual consumer" thing is drivers/regulator/virtual.c
and you'll have to read its code for details ... basically,
write the min and max voltage attributes there (or zero them)
then look at the regulator.* attributes and/or check the
testpoints on your board.

Appended is a script that dumps regulator stats in more
digestible form than raw sysfs:

VMMC1	-- normal, 	3150000 uVolts 	(regulator.0)
	1850000 <--> 3150000 uVolts
VDAC	-- normal, 	1800000 uVolts 	(regulator.1)
	1200000 <--> 1800000 uVolts
VAUX3	-- normal, 	2800000 uVolts 	(regulator.10)
	1500000 <--> 2800000 uVolts
VAUX4	-- off, 	1000000 uVolts 	(regulator.11)
VAUX2	-- normal, 	1500000 uVolts 	(regulator.2)
	1300000 <--> 2800000 uVolts
VUSB1V5	-- normal, 	1500000 uVolts 	(regulator.3)
VUSB1V8	-- normal, 	1800000 uVolts 	(regulator.4)
VUSB3V1	-- normal, 	3100000 uVolts 	(regulator.5)
VUSBCP	-- off, 	4800000 uVolts 	(regulator.6)
VMMC2	-- off, 	2600000 uVolts 	(regulator.7)
VSIM	-- normal, 	1800000 uVolts 	(regulator.8)
	1800000 <--> 3000000 uVolts
VAUX1	-- off, 	3000000 uVolts 	(regulator.9)

Enjoy!

- Dave

[1] http://marc.info/?l=linux-kernel&m=122645403604873&w=2
[2] http://marc.info/?l=linux-kernel&m=122645416305013&w=2
[3] http://marc.info/?l=linux-kernel&m=122645416305018&w=2


#!/bin/bash

cd /sys/class/regulator || exit 1

for F in *
do
	NAME=$(cat $F/name)
	test $NAME = VAUX2_4030 && NAME=VAUX2
	OPMODE=$(cat $F/opmode)
	STATE=$(cat $F/state)
	test $OPMODE != off -a $STATE = disabled && OPMODE=off
	UVOLTS="0"
	test -f $F/microvolts && UVOLTS=$(cat $F/microvolts)

	echo $NAME"	-- "$OPMODE", 	"$UVOLTS" uVolts 	("$F")"

	test $OPMODE = off && continue

	# FIXME:  may have device links ... display them too
	test ! -f $F/min_microvolts && continue

	UVOLTS_MIN=$(cat $F/min_microvolts)
	UVOLTS_MAX=$(cat $F/max_microvolts)
	echo "	"$UVOLTS_MIN" <--> "$UVOLTS_MAX uVolts

done
