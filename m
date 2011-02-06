From: Grant Erickson <marathon96@gmail.com>
Subject: Re: How to completely switch off LCD backlight
Date: Sun, 06 Feb 2011 09:30:29 -0800
Message-ID: <C9741AB5.23E3E%marathon96@gmail.com>
References: <0617A24A-1BF3-40E0-B36E-017423BB5DF1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1BFRaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Feb 2011 12:30:39 -0500
Received: by iyj8 with SMTP id 8so1420018iyj.19
        for <linux-omap@vger.kernel.org>; Sun, 06 Feb 2011 09:30:39 -0800 (PST)
In-Reply-To: <0617A24A-1BF3-40E0-B36E-017423BB5DF1@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On 2/6/11 9:09 AM, Elvis Dowson wrote:
>        I've got LCD backlight brightness control working with a custom
> beagleboard design, with the LCD backlight pwm control signal connected to
> OMAP3503's gpt9_pwm_evt timer.
> 
> GPIO 96 is connected to the LCD LED enable pin for controlling the on/off for
> the LCD backlight.
> 
> I also see a bl_power file in /sys/class/backlight/beagleboard/ folder.
> 
> # ls /sys/class/backlight/beagleboard
> uevent
> subsystem
> bl_power
> brightness
> actual_brightness
> max_brightness
> boost
> pwm_fq
> min_duty
> power
> 
> I want to be able to fully turn the LCD backlight on and off. How do I map
> GPIO 96 to bl_power?
> 
> Right now, if I blank the LCD using the following command, it gives me a white
> screen, but the backlight doesn't turn off
> 
> $ echo 1 > /sys/class/graphics/fb0/blank

Elvis:

The following script should be instructive:

    device="/sys/devices/platform/pwm-backlight.0/backlight/pwm-backlight.0"
    power="${device}/bl_power"
    brightness="${device}/brightness"
    max="${device}/max_brightness"

    usage () {
        echo "Usage `basename ${0}` [[ --enable | --disable ] | --max | [
brightness ]]"
    
        exit ${1}
    }

    get_brightness () {
        cat ${brightness}
    }

    set_brightness () {
        echo ${1} > ${brightness}
    }

    max_brightness () {
        cat ${max}
    }

    disable_backlight () {
        echo 1 > ${power}
    }

    enable_backlight () {
        echo 0 > ${power}
    }

    if [ $# -eq 1 ]; then
        if [ "${1}" = "--enable" ]; then
            enable_backlight
        elif [ "${1}" = "--disable" ]; then
            disable_backlight
        elif [ "${1}" = "--max" ]; then
            max_brightness
        else
            set_brightness ${1}
        fi
    else
        get_brightness
    fi

Best,

Grant


