From: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
Subject: Re: Beagleboard -XM and 32GB microSD card oddities
Date: Thu, 30 Jun 2011 16:52:08 +0100
Message-ID: <4E0C9BA8.80506@blueyonder.co.uk>
References: <4E0C4703.9000207@blueyonder.co.uk> <1309445038.308.10.camel@gregoire-laptop>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <beagleboard+bncCKzTgayWERCvt7LwBBoEFuVmLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1309445038.308.10.camel@gregoire-laptop>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: gregoire-7MYmUchvxQsoX9w8sEfDPVaTQe2KTcn/@public.gmane.org
Cc: Beagle Board <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I just had a closer look with a magnifier, it's Class 6.
Regards
Sid.

On 30/06/11 15:43, Gregoire Gentil wrote:
> Is your card labeled SDHC or SDXC? Can you give the specs of your card?
> Have you tried on Pandaboard?
>
> Gr=E9goire
>
> On Thu, 2011-06-30 at 10:50 +0100, Sid Boyce wrote:
>> I'm not really looking for a solution, just supplying some information
>> in case anyone is contemplating a>16GB card.
>>
>> Using Ubuntu 11.04 ARM or x86_64, I cannot create an ext4 partition that
>> will mount. Doing fsck.ext4 appears to fix the filesystem, but rerunning
>> fsck.ext4 a second time gives the same errors.
>>
>> Only BTRFS works.
>>
>> A BTRFS partition can be created without a problem. I then use rsync to
>> copy across all the data from the 16GB (ext4) partition and it mounts
>> without errors. After the rsync I create the excluded directories proc,
>> sys, tmp, media.
>>
>> I get a kernel oops (2.6.39-x1) on boot up of the 32GB card.
>> I'm still trying to figure why I'm getting the oops that I don't have on
>> the original 16GB card.
>> Regards
>> Sid.
>
>


--=20
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

--=20
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.
For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.
