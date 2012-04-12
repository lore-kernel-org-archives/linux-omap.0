From: "V, Aneesh" <aneesh@ti.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 12 Apr 2012 12:58:55 -0700
Message-ID: <CAM=4YEQ6_+7xPwi2jucks1P9p8tO3cSG7S0s=VVJVrueb4fB=g@mail.gmail.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
	<alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
	<20120412030044.GA26236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120412030044.GA26236@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mgreer@animalcreek.com, msalter@redhat.com
List-Id: linux-omap@vger.kernel.org

Hi Greg,

On Wed, Apr 11, 2012 at 8:00 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Apr 11, 2012 at 08:44:39PM -0600, Paul Walmsley wrote:
>> Cc Mark Greer, Mark Salter
>>
>> Hi Greg, Aneesh,
>>
>> On Sat, 17 Mar 2012, Aneesh V wrote:
>>
>> > Add a driver for the EMIF SDRAM controller used in TI SoCs
>> >
>> > EMIF is an SDRAM controller that supports, based on its revision,
>> > one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
>> > for LPDDR2.
>>
>> Just checking to see what the current state of this series is. =A0Gr=
eg, are
>> you considering this for merging, or are there remaining issues? =A0=
Aneesh,
>> do you have any remaining issues to resolve with this set?
>
> What about the review comment about devfreq?

I see that Santosh has already commented on this.
My views are similar, that frequency update is only one of the
many functions of the driver.

>
>> This is useful not only for OMAP4 and AM3517/3505, but also will pro=
bably
>> be useful for the C6x chips that Mark Salter is working on.
>
> It's still in my "to-review" queue, that I'm slowly making my way
> through. =A0So it's not lost, but I would like to get the devfreq
> interface question cleared up first.

Thanks. I will wait for your review then. Once I have your comments
I will re-work and submit in the new directory structure proposed.

thanks,
Aneesh
