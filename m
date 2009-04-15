From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [PATCH 3/3] V4L2 Driver for OMAP3/3 DSS.
Date: Wed, 15 Apr 2009 19:04:08 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25183A@dbde02.ent.ti.com>
References: <60676.207.214.87.58.1239029832.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <60676.207.214.87.58.1239029832.squirrel@webmail.xs4all.nl>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil@xs4all.nl]
> Sent: Monday, April 06, 2009 8:27 PM
> To: Shah, Hardik
> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Jadav, Brijesh R;
> Hiremath, Vaibhav
> Subject: RE: [PATCH 3/3] V4L2 Driver for OMAP3/3 DSS.
> 
> 
> > Hi Hans,
> > Please find my comments inline. Most of the comments are taken care of.
> 
> > 2.  In DSS rotation is accomplished by some memory algorithm but its quite
> > costly so -1 is essentially same as 0 degree but with out the overhead.
> > But if mirroring is on then we have to do the 0 degree rotation with
> > overhead using some memory techniques.  So from user point of view he will
> > only be setting 0 but internally driver will take it as -1 or 0 depending
> > upon the mirroring selected.
> 
> Hi Hardik,
> 
> I just looked over these comments and I'll do a full review in the weekend
> when I'm back from San Francisco. But just one quick remark regarding this
> magic -1 number: wouldn't it be better to write a small inline function
> like this:
> 
> /* return true if we need to rotate or mirror, return false if we
>    don't have to do anything here. */
> static inline int needs_rotate(struct foo *foo)
> {
>     return foo->rotate != 0 || foo->mirror;
> }
> 
> I think this is much more understandable. It's up to you, though.
> 
> Regards,
[Shah, Hardik] Hi All,
Any comment on this series of patches will be appreciated.

Hans,
Did you get a chance to look at it?

> 
>         Hans
> 
> --
> Hans Verkuil - video4linux developer - sponsored by TANDBERG
> 

