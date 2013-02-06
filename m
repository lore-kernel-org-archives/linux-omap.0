From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Wed, 6 Feb 2013 17:03:36 +0200
Message-ID: <511270C8.70105@ti.com>
References: <20121004173107.GD3874@atomide.com> <20121004175742.GB9702@arwen.pp.htv.fi> <20121005013910.GI3874@atomide.com> <20121005162717.GL3874@atomide.com> <CAFp+6iEQ85EEt2m7f8WSo8y7te62O_R4iia3_xiSMjzLXrAy5g@mail.gmail.com> <20130206135126.GA6773@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130206135126.GA6773-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/06/2013 03:51 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Feb 06, 2013 at 05:27:52PM +0530, Vivek Gautam wrote:
>> Hi Tony,
>>
>>
>> On Fri, Oct 5, 2012 at 9:57 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [121004 18:41]:
>>>>>
>>>>>> Also on the EHCI port, I've seen issues where unplugging
>>>>>> the cable hangs kernel with an infinite loop. But that happens
>>>>>> only occasionally, sorry does not seem to happen right
>>>>>> now so no output to paste here. Or maybe this issue
>>>>>> has already been fixed?
>>>
>>> Looks like the system eventually recovers from the EHCI issue
>>> after about fivew minutes or so of spamming the logs. It seems
>>> the ehci-omap errors are:
>>>
>>> [62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
>>> [62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
>>> [62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule
>>>
>>> More data below.
>>>
>>
>> Is this issue fixed ?
>> Actually we too are getting very similar issue with samsung exynos5250 hardware.
>> With latest 'usb-next' kernel and supporting arch patches, when i use
>> following test scenerio:
>> Connect a USB 2.0 external hub to USB 2.0 port, and connect mice or
>> keyboard enumeration and
>> functionality is fine but once disconnecting the HID we get to see the
>> error log:
>> hid-generic 0003:04B3:3025.0002: can't reset device,
>> s5p-ehci-1.3/input0, status -71
>>
>> When i tried to enable CONFIG_USB_DEBUG, get the following log:
> 
> looks like it's not OMAP-specific. Alan any tips ?
> 

I can't reproduce the problem on Panda, but I can on Beagle with a slightly
different behaviour.

1) connecting/disconnecting device directly to the beagleboard's USB port works fine.

2) If I connect a USB Hub to the port and connect a device to it after the hub has
autosuspended, the device is never detected.
doing lsusb after that triggers the detection and produces a lot of transaction errors.
Beagle log is below, before and after 'lsusb'

I suppose this doesn't affect Panda because it has a hub connected immediately below the
root hub that never suspends (as ethernet is hardwired to it).

So there must be some problem in the hub drivers.

cheers,
-roger

root@beagleboard:~# [   62.666595] usb usb1: usb wakeup-resume
[   62.670684] usb usb1: usb auto-resume
[   62.674591] ehci-omap ehci-omap.0: resume root hub
[   62.679687] hub 1-0:1.0: hub_resume
[   62.683471] ehci-omap ehci-omap.0: GetStatus port:2 status 001803 0  ACK POWER sig=j CSC CONNECT
[   62.692779] hub 1-0:1.0: port 2: status 0501 change 0001
[   62.772460] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
[   62.778533] hub 1-0:1.0: port 2, status 0501, change 0000, 480 Mb/s
[   62.849182] ehci-omap ehci-omap.0: port 2 reset complete, port enabled
[   62.856109] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   62.929931] usb 1-2: new high-speed USB device number 4 using ehci-omap
[   62.998352] ehci-omap ehci-omap.0: port 2 reset complete, port enabled
[   63.005279] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   63.107635] usb 1-2: udev 4, busnum 1, minor = 3
[   63.112548] usb 1-2: New USB device found, idVendor=0409, idProduct=005a
[   63.119720] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   63.128936] usb 1-2: usb_probe_device
[   63.132812] usb 1-2: configuration #1 chosen from 1 choice
[   63.139160] usb 1-2: adding 1-2:1.0 (config #1, interface 0)
[   63.145629] hub 1-2:1.0: usb_probe_interface
[   63.150146] hub 1-2:1.0: usb_probe_interface - got id
[   63.155578] hub 1-2:1.0: USB hub found
[   63.200195] hub 1-2:1.0: 4 ports detected
[   63.204467] hub 1-2:1.0: standalone hub
[   63.208679] hub 1-2:1.0: ganged power switching
[   63.213470] hub 1-2:1.0: global over-current protection
[   63.219055] hub 1-2:1.0: Single TT
[   63.222747] hub 1-2:1.0: TT requires at most 16 FS bit times (1332 ns)
[   63.229644] hub 1-2:1.0: Port indicators are supported
[   63.235137] hub 1-2:1.0: power on to power good time: 0ms
[   63.242584] hub 1-2:1.0: local power source is good
[   63.247955] hub 1-2:1.0: no over-current condition exists
[   63.254852] hub 1-2:1.0: enabling power on all ports
[   63.357482] usb 1-2: link qh256-0001/cf68f6c0 start 1 [1/0 us]
[   63.364044] hub 1-2:1.0: state 7 ports 4 chg 0000 evt 0000
[   63.370086] hub 1-2:1.0: hub_suspend
[   63.374023] usb 1-2: unlink qh256-0001/cf68f6c0 start 1 [1/0 us]
[   63.384948] usb 1-2: usb auto-suspend, wakeup 1
[   63.410217] hub 1-0:1.0: hub_suspend
[   63.414062] usb usb1: bus auto-suspend, wakeup 1
[   63.419036] ehci-omap ehci-omap.0: suspend root hub

root@beagleboard:~# 
root@beagleboard:~# lsusb
[   80.925262] usb usb1: usb auto-resume
[   80.929351] ehci-omap ehci-omap.0: resume root hub
[   80.934539] hub 1-0:1.0: hub_resume
[   80.938323] hub 1-0:1.0: port 2: status 0507 change 0000
[   80.945373] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   80.952026] hub 1-0:1.0: hub_suspend
[   80.956024] usb usb1: bus auto-suspend, wakeup 1
[   80.961059] ehci-omap ehci-omap.0: suspend root hub
[   80.968414] usb usb1: usb auto-resume
[   80.980804] ehci-omap ehci-omap.0: resume root hub
[   80.985900] hub 1-0:1.0: hub_resume
[   80.989807] hub 1-0:1.0: port 2: status 0507 change 0000
[   80.995941] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   81.001892] hub 1-0:1.0: hub_suspend
[   81.005767] usb usb1: bus auto-suspend, wakeup 1
[   81.010650] ehci-omap ehci-omap.0: suspend root hub
[   81.017913] usb usb1: usb auto-resume
[   81.035461] ehci-omap ehci-omap.0: resume root hub
[   81.040557] hub 1-0:1.0: hub_resume
[   81.044433] hub 1-0:1.0: port 2: status 0507 change 0000
[   81.050201] usb 1-2: usb auto-resume
[   81.054504] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   81.091827] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   81.101409] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004
[   81.121917] usb 1-2: finish resume
[   81.125671] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 1
[   81.132415] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[   81.139160] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[   81.145904] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
[   81.152679] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[   81.159423] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
[   81.166168] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
[   81.172912] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 8
[   81.179656] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
[   81.186431] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
[   81.193298] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
[   81.200164] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
[   81.207031] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
[   81.213928] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
[   81.220794] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
[   81.227569] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
[   81.234344] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
[   81.241119] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[   81.247894] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[   81.254699] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
[   81.261535] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 21
[   81.268402] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
[   81.275207] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 23
[   81.282043] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
[   81.288909] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
[   81.295806] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[   81.302673] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
[   81.309539] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
[   81.316406] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[   81.323303] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 30
[   81.330169] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
[   81.336944] ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
[   81.342987] usb 1-2: retry with reset-resume
[   81.413726] ehci-omap ehci-omap.0: port 2 full speed --> companion
[   81.420288] ehci-omap ehci-omap.0: GetStatus port:2 status 003801 0  ACK POWER OWNER sig=j CONNECT
[   81.430114] hub 1-0:1.0: port_wait_reset: err = -16
[   81.435363] hub 1-0:1.0: port 2 not enabled, trying reset again...
[   81.442382] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004
[   81.667083] ehci-omap ehci-omap.0: GetStatus port:2 status 00300a 0  ACK POWER OWNER sig=se0 PEC CSC
[   81.677032] hub 1-0:1.0: logical disconnect on port 2
[   81.682403] usb 1-2: gone after usb resume? status -19
[   81.687896] usb 1-2: can't resume, status -19
[   81.692565] hub 1-0:1.0: logical disconnect on port 2
[   81.698394] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0004
[   81.704376] ehci-omap ehci-omap.0: GetStatus port:2 status 00300a 0  ACK POWER OWNER sig=se0 PEC CSC
[   81.714172] hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
[   81.720703] usb 1-2: USB disconnect, device number 4
[   81.726043] usb 1-2: unregistering device
[   81.730346] usb 1-2: unregistering interface 1-2:1.0
[   81.739257] usb 1-2: usb_disable_device nuking all URBs
[   81.750579] usb usb2: usb auto-resume
[   81.754699] ohci-omap3 ohci-omap3.0: resume root hub
[   81.840057] hub 2-0:1.0: hub_resume
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
root@beagleboard:~# [   81.911682] hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
[   81.919647] hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   81.925994] hub 1-0:1.0: hub_suspend
[   81.929840] usb usb1: bus auto-suspend, wakeup 1
[   81.934814] ehci-omap ehci-omap.0: suspend root hub
[   81.940582] hub 2-0:1.0: hub_suspend
[   81.944458] usb usb2: bus auto-suspend, wakeup 1
[   81.949401] ohci-omap3 ohci-omap3.0: suspend root hub

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
