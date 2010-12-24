From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Thu, 23 Dec 2010 17:37:12 -0700
Message-ID: <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
 <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com>
 <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com> <871v58xf0k.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:33005 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab0LXAhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 19:37:33 -0500
Received: by iyf40 with SMTP id 40so2959455iyf.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 16:37:32 -0800 (PST)
In-Reply-To: <871v58xf0k.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, Eric Miao <eric.miao@canonical.com>

On Thu, Dec 23, 2010 at 4:09 PM, Ben Gamari <bgamari.foss@gmail.com> wrote:
> On Thu, 23 Dec 2010 14:38:57 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Tue, Dec 21, 2010 at 10:56 AM, Ben Gamari <bgamari.foss@gmail.com> wrote:
>> > This mechanism is in large part stolen from the s3c64xx-spi module. To
>> > use this functionality, one simply must define a set_level function to
>> > set the CS state and a omap2_mcspi_csinfo struct for each chip select in
>> > the board file.
>> >
>> > Each spi_board_info.controller_data should then be set
>> > to point to the appropriate csinfo struct. This will cause the driver to
>> > call the csinfo->set_level function instead of toggling the McSPI chip
>> > select lines.
>> >
>> > Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
>>
>> I'd rather see the spi driver modified to use the gpio api directly.
>> The drivers are already tending in that direction and it doesn't
>> require machine specific set_level functions to be defined.
>>
> The reason I left this up to the board is it's easy to foresee cases
> where you want a non-trivial mapping between logical CS numbers and CS
> pin states. In my case, I using a 2-to-4 multiplexer as the source of
> chip select.

Hi Ben,

I understand and appreciate the motivation.  However in practice, the
gpio api is sufficient for pretty much any use case, even when the
backing gpio controller driver ends up driving some oddball device
with different constraints.  The big downside to using a callback is
that it forces all users to do the extra work of implementing the
callback.  With the gpio api, only the oddball cases have to do extra
code (to adapt the custom device to the gpio api).

g.
