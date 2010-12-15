From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5 v3] OMAP: idle path errata fixes
Date: Wed, 15 Dec 2010 15:40:12 -0600
Message-ID: <4D0935BC.5000706@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com> <87k4jdypx0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060205060701030306090409"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45363 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284Ab0LOVkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 16:40:16 -0500
Received: by mail-gw0-f44.google.com with SMTP id 17so1557188gwj.3
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 13:40:15 -0800 (PST)
In-Reply-To: <87k4jdypx0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Charulatha Varadarajan <charu@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tao Hu <tghk48@motorola.com>, Tony Lindgren <tony@atomide.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

This is a multi-part message in MIME format.
--------------060205060701030306090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman had written, on 12/13/2010 09:49 PM, the following:
> Hi Nishanth,
> 
> Nishanth Menon <nm@ti.com> writes:
> 
>> as discussed in [1], here is step 2 - idle path errata fixes.
>> this is the next rev incorporating comments from V2 post
>> of this series.
> 
> I had a couple small comments on individual patches.
> 
> In addition, in the next series, can you report the platforms it was
> tested on, and how it was tested (retention idle/suspend, off
> idle/suspend, CPUidle enabled?, etc.)
> 
> I tested this series (and Jean's cleanup patch) on 34xx/n900 with
> retention idle & suspend and off idle & suspend with and without CPUidle
> enabled.)
> 
> Also, when posting an updated series, can you update the version of all
> patches in the series, even if they are unchanged?  This makes more
> more explicit versioning, keeps things clearer in patchwork and avoids
> problems with dumb mailers who thread by subject only.
> 
> Also, please Cc linux-arm-kernel when posting the next version. 
ok will do. for reference, I wrote a script to make things easy for all 
- attached.

With the pm-fixes being merged to master, I tested today with latest 
kernel.org master commit: 0fcdcfb against omap2plus_defconfig without 
any of my patches applied:

Results:
SDP3630:
Log: http://pastebin.mozilla.org/889642
Summary:
SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (8 sec) 

SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (8 sec) 

IDLE:OFF test | PASS | OFF: 1->24| RET:1 ->1 (21 sec) 

IDLE:RET test | PASS | OFF: 24->| RET:1 ->23 (21 sec)

SDP3430 (ES3.1):
Log: http://pastebin.mozilla.org/889643
Summary:
SUSPEND:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (7 sec) 

SUSPEND:RET test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 

IDLE:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 

IDLE:RET test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec)

Core never hits OFF/retention.

-- 
Regards,
Nishanth Menon

--------------060205060701030306090409
Content-Type: application/x-sh;
 name="suspend-idle.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suspend-idle.sh"

#!/bin/ash
# Quick script to verify SUSPEND Resume behavior without human intervention
# Refer: http://elinux.org/OMAP_Power_Management for details

# Some params that might change based on the environment
DEBUG=/sys/kernel/debug
SYS=/sys
PROC=/proc

PMDEBUG=$DEBUG/pm_debug
VOLTAGE_OFF=$PMDEBUG/voltage_off_mode
UART1=$SYS/devices/platform/omap/omap-hsuart.0/sleep_timeout
UART2=$SYS/devices/platform/omap/omap-hsuart.1/sleep_timeout
UART3=$SYS/devices/platform/omap/omap-hsuart.2/sleep_timeout

# Setup cpu idle
cpu_idle(){
	echo -n "$1" > $PMDEBUG/sleep_while_idle
}

# setup off mode
off_mode(){
	echo -n "$1" > $PMDEBUG/enable_off_mode
}

# Do a suspend
suspend_me(){
	echo -n "mem" > $SYS/power/state
}

# get my core data (This is the last domain to hit lowest power state)
core_count(){
	cat $PMDEBUG/count |grep "^core_pwrdm"
}

# get my retention counter
core_ret_count(){
	core_count|cut -d ',' -f3|cut -d ':' -f2
}

# get my off counter
core_off_count(){
	core_count|cut -d ',' -f2|cut -d ':' -f2
}

# setup wakeup timer - automated testing
wakeup_timer(){
	echo -n "$1" > $PMDEBUG/wakeup_timer_seconds
	echo -n "$2" > $PMDEBUG/wakeup_timer_milliseconds
}

# Setup our uart to be inactivity timer
setup_tty_sleep_timeout() {
	if [ -f $UART1 ]; then
		echo -n "$1" > $UART1
	fi
	if [ -f $UART2 ]; then
		echo -n "$1" > $UART1
	fi
	if [ -f $UART3 ]; then
		echo -n "$1" > $UART3
	fi

}

# Measurement Start
measure_start(){
	OFF_START=`core_off_count`
	RET_START=`core_ret_count`
	TIME_START=`date "+%s"`
}
# Measurement End
measure_end(){
	OFF_END=`core_off_count`
	RET_END=`core_ret_count`
	TIME_END=`date "+%s"`
}
# Common formatted print
measure_print(){
	DUR=`expr $TIME_END - $TIME_START`
	echo "$1 | $2 | OFF: $OFF_START->$OFF_END| RET:$RET_START ->$RET_END ($DUR sec)"
}

# Disable everything
disable_all(){
	# disable voltage off
	if [ -f $VOLTAGE_OFF ]; then
		echo -n "0" >$VOLTAGE_OFF
	fi
	setup_tty_sleep_timeout 0
	wakeup_timer 0 0
	off_mode 0
	cpu_idle 0
}

# test idle - core ret
test_idle_ret() {
	disable_all
	measure_start
	setup_tty_sleep_timeout 5
	cpu_idle 1
	sleep 20
	disable_all
	sleep 1;sync
	measure_end
	RESULT=FAIL
	if [ $RET_START -lt $RET_END ]; then
		RESULT=PASS
	fi
	measure_print "IDLE:RET test" $RESULT
}

# test idle - core off
test_idle_off() {
	disable_all
	measure_start
	setup_tty_sleep_timeout 5
	off_mode 1
	cpu_idle 1
	sleep 20
	disable_all
	sleep 1;sync
	measure_end
	RESULT=FAIL
	if [ $OFF_START -lt $OFF_END ]; then
		RESULT=PASS
	fi
	measure_print "IDLE:OFF test" $RESULT
}

# test suspend - core ret
test_suspend_ret() {
	disable_all
	measure_start
	wakeup_timer 5 0
	suspend_me
	disable_all
	sleep 1;sync
	measure_end
	RESULT=FAIL
	if [ $RET_START -lt $RET_END ]; then
		RESULT=PASS
	fi
	measure_print "SUSPEND:RET test" $RESULT
}

# test suspend - core off
test_suspend_off() {
	disable_all
	measure_start
	off_mode 1
	wakeup_timer 5 0
	suspend_me
	disable_all
	sleep 1;sync
	measure_end
	RESULT=FAIL
	if [ $OFF_START -lt $OFF_END ]; then
		RESULT=PASS
	fi
	measure_print "SUSPEND:OFF test" $RESULT
}

# mount up the basic fs
already_mntd=`mount|grep $PROC`
if [ x == x"$already_mntd" ]; then
	mount -t proc none $PROC
fi

already_mntd=`mount|grep $SYS`
if [ x == x"$already_mntd" ]; then
	mount -t sysfs none $SYS
fi
already_mntd=`mount|grep $DEBUG`
if [ x == x"$already_mntd" ]; then
	mount -t debugfs none $DEBUG
fi
# Lets run the tests one by one..
NR=""
R=`test_suspend_off`
echo $R
NR="$NR\n$R"
R=`test_suspend_ret`
echo $R
NR="$NR\n$R"
R=`test_idle_off`
echo $R
NR="$NR\n$R"
R=`test_idle_ret`
echo $R
NR="$NR\n$R"
# Print End result summary
cat $PMDEBUG/count

# Print test summary
echo -e "$NR"

--------------060205060701030306090409--
