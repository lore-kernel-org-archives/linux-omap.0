From: Adam Baker <linux@baker-net.org.uk>
Subject: Re: [RFC] How to pass camera Orientation to userspace
Date: Sun, 22 Feb 2009 21:46:32 +0000
Message-ID: <200902222146.33136.linux@baker-net.org.uk>
References: <200902180030.52729.linux@baker-net.org.uk> <alpine.LNX.2.00.0902221225310.10870@banach.math.auburn.edu> <49A1A03A.8080303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <49A1A03A.8080303@redhat.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: kilgota@banach.math.auburn.edu, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, Jean-Francois Moine <moinejf@free.fr>, Olivier Lorin <o.lorin@laposte.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, Trent Piepho <xyzzy@speakeasy.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday 22 February 2009, Hans de Goede wrote:
> We want to be able to differentiate between a cam which has its sensor
> mounted upside down, and a cam which can be pivotted and happens to be
> upside down at the moment, in case of any upside down mounted sensor, we
> will always want to compentsate, in case of a pivotting camera wether we
> compensate or not could be a user preference.


If we take Olivier Lorin's gl-860 case though, how do we define what is the 
normal orientation and what is pivoted, it is likely we'd just decide the 
direction where the sensor output is the right way up is normal and the other 
is pivoted and then what info have you got from having multiple flags.

In order to explain what I mean it is probably best to refer to rotations in 
terms of pitch, yaw and roll (as per the definitions at 
http://en.wikipedia.org/wiki/Flight_dynamics) where the forward direction is 
the shooting direction.

When still cameras are fitted with gravity sensors they are normally set up 
with the intention of measuring roll and will often get confused by 90 
degrees of pitch. If a laptop is fitted with a camera that can either record 
the user or the view looking away from the user then the camera needs to be 
able to either pitch or yaw but not roll. If the camera yaws then no 
correction is needed but if it pitches then the resulting image needs 
rotating to be the correct way up (and in that scenario it is improbable that 
the user doesn't want the correction applied). Other than the fact that one 
needs correcting and the other doesn't these options appear identical to the 
user and so manufacturers provide one or the other but not both.

If a video camera had a roll sensor (or even, as a believe some specialist 
tripods can manage, a full set of roll, pitch and yaw measurements) then a 
substantially different mechanism is needed to provide access to that data 
but in the absence of anyone having access to such equipment I don't think we 
can design the interface now.

Adam
