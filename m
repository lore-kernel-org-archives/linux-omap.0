From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Fri, 5 Oct 2012 09:27:17 -0700
Message-ID: <20121005162717.GL3874@atomide.com>
References: <20121004173107.GD3874@atomide.com>
 <20121004175742.GB9702@arwen.pp.htv.fi>
 <20121005013910.GI3874@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121005013910.GI3874-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [121004 18:41]:
> > 
> > > Also on the EHCI port, I've seen issues where unplugging
> > > the cable hangs kernel with an infinite loop. But that happens
> > > only occasionally, sorry does not seem to happen right
> > > now so no output to paste here. Or maybe this issue
> > > has already been fixed?

Looks like the system eventually recovers from the EHCI issue
after about fivew minutes or so of spamming the logs. It seems
the ehci-omap errors are:

[62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
[62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
[62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule

More data below.

Regards,

Tony

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=panda-ehci-hang-on-unplug

...
[62927.200012] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62927.215606] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
[62927.220092] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
[62927.225738] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
[62927.232238] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
[62927.236633] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62927.241119] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[62927.251098] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62927.258605] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
[62927.264343] usb 1-1.3.7.5: link qh8-0e01/ea5632c0 start 6 [1/2 us]
[62927.274353] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
[62927.276092] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
[62927.280700] usb 1-1.3.7: clear tt 4 (0120) error -71
[62927.289245] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62927.292633] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
[62927.296356] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[62927.302368] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
[62927.307098] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
[62927.308258] hid-generic 0003:047D:1020.000C: can't reset device, ehci-omap.0-1.3.7.4/input0, status -1
[62927.317230] usb 1-1.3.7: clear tt buffer port 5, a26 ep0 t00080248
[62927.322357] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62927.324981] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62927.330718] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
[62927.336364] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
[62927.348114] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
[62927.349090] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62927.356475] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[62927.368469] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62927.372253] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
[62926.616607] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62926.622863] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
[62926.627746] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62926.628112] ehci-omap ehci-omap.0: devpath 1.3.7.4 ep0out 3strikes
[62926.639404] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
[62926.643737] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62926.651123] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
[62926.655609] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62926.660125] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
[62926.667480] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
[62926.669982] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 1
[62926.680603] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[62926.686126] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
[62926.693237] usb 1-1.3.7: clear tt buffer port 5, a26 ep0 t00080248
[62926.694091] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
[62926.706359] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62926.709350] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
[62926.712554] usb 1-1.3.7: clear tt 4 (0120) error -71
[62926.714599] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
[62926.720855] ehci-omap ehci-omap.0: devpath 1.3.7.5 ep0out 3strikes
[62926.729248] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62926.732238] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
[62926.736358] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
[62926.742736] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
[62926.755615] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
[62926.756744] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62926.763610] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62926.769226] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62926.780609] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62926.782745] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62926.789978] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[62926.801605] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
[62926.804626] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62926.809844] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62926.815734] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62926.828979] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
[62926.829101] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62926.840118] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
[62926.851745] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
[62926.855987] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
[62926.863220] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
[62926.876251] ehci-omap ehci-omap.0: devpath 1.3.7.4 ep0out 3strikes
[62926.876403] hid-generic 0003:047D:1020.000C: can't reset device, ehci-omap.0-1.3.7.4/input0, status -1
[62926.897125] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
[62926.903747] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[62926.920989] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
...

After waiting for several minutes, it stops, and dmesg shows:

# dmesg | grep -i omap
[62934.193389] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62934.193542] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[62934.193664] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
[62934.193786] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62934.194030] ehci-omap ehci-omap.0: reused qh ed0fbdc0 schedule
[62934.194122] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
[62934.194274] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
[62934.194396] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 8
[62934.194519] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
[62934.194641] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
[62934.194793] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
[62934.194915] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
[62934.195037] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
[62934.195159] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
[62934.195281] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
[62934.195404] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
[62934.195526] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
[62934.195648] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62934.195770] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62934.195892] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
[62934.196014] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 21
[62934.196166] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
[62934.196289] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 23
[62934.196411] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
[62934.196533] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
[62934.196655] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[62934.196777] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
[62934.196899] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
[62934.197021] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62934.197143] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 30
[62934.197265] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
[62934.197418] ehci-omap ehci-omap.0: devpath 1.3.7.5 ep0out 3strikes
1.3.7.5/input0, status -71
[62934.197784] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 1
[62934.197906] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
[62934.198028] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
[62934.198150] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
[62934.198272] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
[62934.198394] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
[62934.198516] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
[62934.198638] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 8
[62934.198791] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
[62934.198913] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
[62934.199035] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
[62934.199157] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
[62934.199279] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
[62934.199401] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
[62934.199523] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
[62934.199645] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
[62934.199768] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
[62934.199890] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
[62934.200042] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
[62934.200042] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 1
[62934.200164] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
[62934.200164] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 2
[62934.200286] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 21
[62934.200286] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 3
[62934.200408] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
[62934.200531] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 23
[62934.200653] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
[62934.200775] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
[62934.200897] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
[62934.201019] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
[62934.201141] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
[62934.201263] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
[62934.201416] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 30
[62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
[62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
[62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule
...

--k1lZvvs/B4yU6o8G--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
