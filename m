From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Sun, 31 Mar 2013 12:17:21 +0300
Message-ID: <5157FF21.9000702@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il> <51547790.7010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55948 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730Ab3CaJR2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Mar 2013 05:17:28 -0400
In-Reply-To: <51547790.7010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 03/28/13 19:02, Tomi Valkeinen wrote:
> On 2013-03-28 18:09, Igor Grinberg wrote:
>> On 03/28/13 14:49, Tomi Valkeinen wrote:
>>> Boards with multiple display options for the same video bus have all the
>>> possible linux display devices present at the same time. Only one of
>>> those devices should be used at a time, as the video bus cannot be
>>> shared.
>>
>> Yes, only one can be used at a time, but you can switch at runtime...
> 
> Yep. But the panel drivers need to know about this, and they cannot do
> more or less anything in the driver probe function, which I think should
> be the place to reserve resources and do initialization. With the
> current model that would lead to multiple drivers trying to acquire the
> same resources.

Yep, this is a problem, but it only means that probably
the platform device framework is not suitable for this.

What about having some kind of display manager which will have a private
list of registered devices and will instantiate only those that are marked
active?
This also might be useful with DT.

> 
>>> This model is hacky, and will be changed in the forthcoming DSS patches
>>> to a model where only one display device can be present on a single
>>> video bus.
>>
>> What do you mean by "present"?
>> Is it active? or registered? or compiled in?
> 
> I mean that only one device can be registered. Well, nothing strictly
> prevents having multiple devices registered, but if the devices have
> matching drivers, the drivers would acquire the same resources. Possibly
> the same gpios, but at least the same video bus.

Well, I think, we should follow/extend the already existing EDID concept...
Instantiate a display device only when one has been "plugged in".
By "plugged in" I mean enabled - made active.

> 
>>> This patch creates Kconfig options to select which of the display
>>> devices is present on the board. While this model is also somewhat
>>> hacky, and prevents us from using a single kernel image for all the
>>> display options, it allows us to make the DSS driver changes for DT
>>> adaptation. And with DT, the information about display devices can be
>>> passed from the bootloader, solving the mess.
>>
>> Hmmm, the fact that we cannot use the same binary for multiple displays...
>> This does not sound right and good at all...
>> While we try to move to support multiple platforms in the same binary, we
>> cannot support multiple displays? I agree that the multiplatform stuff is
>> not really related, but you know what I mean...
> 
> Yes, I quite agree that this sucks =). There are a few reasons I chose
> to try this approach:
> 
> - The whole multi-display feature is hacky
> 
> - DT support for DSS has been in development too long time. We really
> need it, preferably yesterday. This change helps getting DT support ready.

Yes, but I don't think this should involve removing the existing
functionality..
Let me exaggerate a bit: this is like removing ARM support from mainline,
so it will make less noise and headache to Linus...

> 
> - Common Display Framework won't (most likely) support this kind of
> feature, as the feature itself is rather hacky, so this would anyway
> disappear.

Hmmm, I don't think it will disappear, but instead you will keep
receiving hacky patches to bring that support in...
So, IMO, it would be better designed to support this or at least
keep it in mind, so there will no necessity for hacky patches...

> 
> - DT support should solve this (except for runtime switching), and the
> board files are on the way out (as far as I understand). So in that
> sense this is temporary.

But not the runtime switching...
The runtime switching should be done in the framework.

> 
> - Keeping this feature functional consumes considerable amount of
> man-hours, which are in short supply.

This is where you should request some help from the interested sides...
And mailing lists are quite handy.

> 
> I still feel quite bad about this, though. Any ideas how to manage this
> better are appreciated.
> 
>> I bet there must be a much better solution for DT support.
> 
> Yes, I think I covered that in the last email. DT will solve the issue,
> except for runtime switching, which is still open. I'm not sure how
> these board specific drivers would be implemented.

Well, at least the generic kernel display parameter will do more than
half of the job.
We can discuss the runtime switch stuff, but it is really a non-sense
to compile a kernel for specific display...


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRV/8gAAoJEBDE8YO64EfaGOQQAIEnXwrHiZFlsMkCo5n8uUok
qBBvEoFh5s1h2aaDNna3Q7tvKF42UlaGtZPqwl5bDUHimcEaLnNPy14MQJ/w/dHN
AvDaI2ZoqGCYDVjVa0KUCWqL6Chm7ZpAoU9NeY3T3+U8S7kIeizz0oBJKoZ4bfpk
g6Kq5vnbi36pCWFMqQe+7fEn5CHJNHTp+miPpq3Dsed2zkVgIg9re0nTxpQjlDHO
+kLwJjrHbCqZoBMzE0MacaibROiHhccQ9Xtf25iVemyHQ6CP6g+ibJduFF7S4pOk
kOwH1NY2QiFGDyA0Tj+kuYsbUYe3E1ds7FCu0/9g2KpiGRqSAqrFDghJzj1PojL+
SxL47jgMkDUehEnBC2Eq3DD5jq4YRd2Sn989FH5ov9GWcyFhzBl72LHHhI78YRpu
3QKGAnAcSVOyNcvkDNYhsJRqs9qUpnn9Z89jrx430ckK+SI4T4qiczn4aFEXFPxC
Zqp8Rmvn95X5D9kMBgMScy1cHzkWRZ32GCKSRkOqnaFim2knxrflnX1Riu11jFCL
k1AK+rKhqUB9FaME3Uyn07s+cTKCVX1TWmnP6Er9ObZkOKR2fR7ZwEmTbhA/m0pe
iefjKf6gxuZV/FX+OnTvivorw2CMfGyweolu2JHj9cTuEGvddeq/LhKz+cEzdMVL
Vpj9krR7L6Hq8dFqz8Dk
=sr0U
-----END PGP SIGNATURE-----
