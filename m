From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Mon, 30 Apr 2012 10:26:45 +0300
Message-ID: <4F9E3EB5.8030104@ti.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com> <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com> <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com> <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk> <20120427193129.GA3951@n2100.arm.linux.org.uk> <20120429203525.GA4618@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040501090904060801040400"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:38049 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab2D3HdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 03:33:24 -0400
Received: by lbbgk15 with SMTP id gk15so1004174lbb.18
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 00:33:21 -0700 (PDT)
In-Reply-To: <20120429203525.GA4618@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

This is a multi-part message in MIME format.
--------------040501090904060801040400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 04/29/2012 11:35 PM, Russell King - ARM Linux wrote:
> Please can someone at TI take a current mainline kernel, build it, and
> test out audio support on the 4430SDP - specifically output through the
> headset jack into a line input, and report when it works.  Thanks.

Try to use my attached aconf for SDP4430 to configure the HS playback.
Note that the HS is not a line out, so on your line-in device it will
cause distortion. If you have a headset/headphone you will have better
quality.
alsactl -f blaze.aconf restore

To play samples with aplay:
aplay -Dplughw:0,0 <wav file>
The sample format fot Legacy McPDM is S32_LE, 96KHz, 24bit (32 bit
sample with 24 LSB).

The slow pace audio playback is because at this point we do not have the
full audio stack up. The AESS IP does not have driver. You need to
disable CONFIG_OMAP_RESET_CLOCKS. This will fic the audio playback speed.

As for the basic usage:
We support up to 5 channel playback on OMAP4 in Legacy mode:
channel 1/2 (stereo): Headset, earpiece
channel 3/4: Handsfree/Line out
channel 5: Vibra

So with stereo sample you can only play to the Headset/Earpiece.
You need to have 5 channel audio, and valid data on channel 5 to be able
to drive the vibra.

-- 
Péter

--------------040501090904060801040400
Content-Type: text/plain; charset=UTF-8;
 name="blaze.aconf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="blaze.aconf"

state.SDP4430 {
	control.1 {
		iface MIXER
		name 'Capture Preamplifier Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 1'
			dbmin -600
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Capture Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 4'
			dbmin 600
			dbmax 3000
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.3 {
		iface MIXER
		name 'Aux FM Volume'
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 7'
			dbmin -1800
			dbmax 2400
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Headset Playback Volume'
		value.0 13
		value.1 13
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 15'
			dbmin -3000
			dbmax 0
			dbvalue.0 -400
			dbvalue.1 -400
		}
	}
	control.5 {
		iface MIXER
		name 'Handsfree Playback Volume'
		value.0 4
		value.1 4
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 29'
			dbmin -5200
			dbmax 600
			dbvalue.0 -4400
			dbvalue.1 -4400
		}
	}
	control.6 {
		iface MIXER
		name 'Earphone Playback Volume'
		value 2
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
			dbmin -2400
			dbmax 600
			dbvalue.0 -2000
		}
	}
	control.7 {
		iface MIXER
		name 'Headset Power Mode'
		value High-Perfomance
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Low-Power
			item.1 High-Perfomance
		}
	}
	control.8 {
		iface MIXER
		name 'PLL Selection'
		value High-Perfomance
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Low-Power
			item.1 High-Perfomance
		}
	}
	control.9 {
		iface MIXER
		name 'AUXR Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'AUXL Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'Earphone Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface MIXER
		name 'Vibra Right Playback'
		value 'Input FF'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Input FF'
			item.1 'Audio PDM'
		}
	}
	control.13 {
		iface MIXER
		name 'Vibra Left Playback'
		value 'Input FF'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Input FF'
			item.1 'Audio PDM'
		}
	}
	control.14 {
		iface MIXER
		name 'Headset Right Playback'
		value 'HS DAC'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Off
			item.1 'HS DAC'
			item.2 'Line-In amp'
		}
	}
	control.15 {
		iface MIXER
		name 'Headset Left Playback'
		value 'HS DAC'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Off
			item.1 'HS DAC'
			item.2 'Line-In amp'
		}
	}
	control.16 {
		iface MIXER
		name 'Handsfree Right Playback'
		value Off
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Off
			item.1 'HF DAC'
			item.2 'Line-In amp'
		}
	}
	control.17 {
		iface MIXER
		name 'Handsfree Left Playback'
		value Off
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Off
			item.1 'HF DAC'
			item.2 'Line-In amp'
		}
	}
	control.18 {
		iface MIXER
		name 'Analog Right Capture Route'
		value Off
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Headset Mic'
			item.1 'Sub Mic'
			item.2 'Aux/FM Right'
			item.3 Off
		}
	}
	control.19 {
		iface MIXER
		name 'Analog Left Capture Route'
		value Off
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Headset Mic'
			item.1 'Main Mic'
			item.2 'Aux/FM Left'
			item.3 Off
		}
	}
}

--------------040501090904060801040400--
