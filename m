From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Sun, 31 Mar 2013 11:39:01 +0300
Message-ID: <5157F625.5070509@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <51546259.3000704@compulab.co.il> <51547462.3070803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:42903 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309Ab3CaIjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Mar 2013 04:39:10 -0400
In-Reply-To: <51547462.3070803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/28/13 18:48, Tomi Valkeinen wrote:
> On 2013-03-28 17:31, Igor Grinberg wrote:
>> On 03/28/13 14:48, Tomi Valkeinen wrote:
>>> So here are the DSS related board file changes for 3.10.
>>>
>>> First there are a bunch of patches adding the Kconfig options so that only one
>>> display device is created for a single video bus. Only Overo had more than two
>>> displays on the same bus, but unfortunately there were multiple boards with a
>>> setup that puts an LCD and DVI output on the same video bus.
>>
>> Hmmm, so basically, if one could switch the display at runtime...
>> This cannot be done anymore...
>> This sounds like feature removal, no?
>> I know several of our clients who used this feature
>> (at least for evaluation purposes).
> 
> At some point in time it was possible to have multiple displays for the
> same bus, and switch them at runtime.
> 
> Sometime later it was changed so that the board file adds all the
> displays, but only one (per bus) is actually added to the list of
> panels, but you could still set the default display in the kernel args,
> and thus you could select which display gets added.

Yeah, I remember we had to hack this to have the functionality back...

> 
> The reason why the multiple-displays-per-bus is problematic is that the
> video bus cannot be shared, and if we have multiple devices on the same
> bus, the drivers need extra trickery, delaying initializations, etc, to
> handle this. And it still doesn't work right, as it's easy to get two
> displays enabled at the same time, configuring the same video bus,
> creating a mess.

Yep, looks like additional display manager framework is needed.
Which will manage the displays on per bus basis?

> 
> Quite often the case is that the other displays are not even present
> physically. But it is true that some boards have gpio switches that can
> be used to change the display during runtime.

I don't think the runtime switch requirement will ever go away, so we'd
better prepare for it wisely.

> 
>> Is there any strong pros you obtain while removing this feature?
> 
> For an user, only indirectly. The change will make things sane on the
> display side, and will thus make it much easier to proceed towards DT
> adaptation, and Common Display Framework. While I can't say it's a
> strict must to remove this feature, I can say that it's been a constant
> headache for me for, well, ever. And I presume CDF would not have this
> feature anyway, as it's rather bad design.

Well, I don't know about the CDF, but the runtime switch was there
for ages... Think of a DVI or an HDMI... they have the EDID stuff
to make the switch work as expected and it really brings multiple
displays to the same video bus.
I see this is only a meter of how we represent things.
Instead of real EDID (or in addition), that comes with the display,
currently we have the panel info already in the kernel and
panel driver with board specific callbacks to make it work.
So abstracting the above (in the long run) to CDF or some other
framework, should suit everybody's needs.
Probably, we will need board specific drivers, but that never
was a problem...

> 
>>> So the ifdeffery is not very nice. But, as discussed, this is the best way
>>> forward, and should be seen as a temporary solution until we get full DT
>>> support.
>>
>> I've missed this discussion, can you please point to it?
> 
> Well, not so much discussion, but a few mails under "Display related
> board specific boot args" subject on l-o. I proposed a board specific
> kernel argument to select the displays present, Tony was less than
> enthusiastic about that.

Yes, I can understand that ;-)

> 
>> And what will change with full DT support?
>> Will we be able to define several displays through DT and
>> select and active one during runtime?
> 
> No, not as such. DT will let the bootloader pass the DT data, thus
> telling which displays are present. So we can have single kernel binary,
> which will work for all the cases.

IMO, single kernel binary is a must.

> 
> Dynamic switching during runtime will still be missing.

This is not good, as it removes a functionality that worked before...

> For that I think
> we need board specific drivers. That driver should know about board
> specific restrictions etc (which are rather missing currently), remove
> the old display device, and create the new one.

Well, yes we need a board specific drivers, but we need even more...
Board specific driver should not poke with devices...
I think for that we will need some kind of generic display manager
(may be a part of CDF) that will deal with the device registration/removal
and board specific drivers should implement some kind of API of the
generic display manger.

> 
> Well, actually, if there was a way to add a device while somehow marking
> it so that no driver will be bound to it... Then the user could use the
> standard sysfs interface to bind a driver to the device. I wonder if
> that could be done...

I don't think this can fit current platform device framework.
But may be I'm missing something...
May be Greg can comment on this? Greg?


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRV/YlAAoJEBDE8YO64Efa8tUP/RAMY1oYNkRpmSnBF6Zqeezz
Boq+Et3rUQpxHVsapYrrOXxRkg9FOhgJ9kWt3T5THJcY2KhUNuNM2fM3+ruvzgzl
DHVqEYpNFUXdd6+Cb5ZN48Txuw2/u1CcStOgJYsAEaskj6CqW4K4l8NhwBXWzKEv
AftKYXKEhhmCQiPIXcOPjGuGxV6jdIn0xl7XolTggBF0fZwIFg22en5jKYCLo/s/
GlMw0jBeyXhtPpgJzs+OWkbwZLdRqEyBasJJliNkrVPUm3rAopQ/+TJRTT3MNCUj
Gc3w9JUI35TNt0P8QDQi2L/Nky+r6pZVV8MHtOT4RXz5euKQllm2yiw4MxVcJr18
XHmcOZcaeoTUYH/J0TW7yJK3+Lox0jWLpx/0VyMomRQF6NtZ2h2TtLWKeyh1HG5z
+10nqj6BFCjvinkRYwwFiL877PBVO1efe8ur0AvdnAwW0dBIvOwcC16M/V5Vpzz3
4azvw/Xtpex0fWFI31usgMd0O8pCOdS96A+x1gmGiZBH4UXAiTN0+VOzvNU43kZ4
KgpHFfrkHKr3DU+SpJJfV49Pgjx2czUEgxMeDGYaPcVwcrkE57aP5XyBp+qPOXfi
Jlh+frSBkZ0LPDVA1Tc5h49bupIV+hxeSiDdZKr1ET2ijkwsewNp9AV1ZILRbICP
mrp5py+udPRaIPjQV8v6
=Vrec
-----END PGP SIGNATURE-----
