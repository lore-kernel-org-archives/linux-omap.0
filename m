From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: omap24xxcam status (Was: v4l2 camera test app)
Date: Mon, 20 Mar 2006 10:27:04 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602A10CB5@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>, ext Komal Shah <komal_shah802003@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David,

I don't see the new sensor interface incorporated in your patch. It is
likely that Micron 2MP camera MT9D111 will be used by more people. The
new sensor interface supports double-context which is an advanced
feature of micron camera.

Regards,
Jian   =20

-----Original Message-----
From: David Cohen [mailto:david.cohen@indt.org.br]=20
Sent: Monday, March 20, 2006 10:10 AM
To: ext Komal Shah
Cc: Ola Helm; Linux-omap-open-source@linux.omap.com; Zhang, Jian
Subject: Re: omap24xxcam status (Was: v4l2 camera test app)

Hi,

I just sent a code that should be compilable and working. I guess the
mainly target is to apply this patch to the public tree. After that, as
Komal said, could be interesting to update the dma code to the omap api
to be easier future reviews.

Regards,

David Cohen

ext Komal Shah wrote:

>--- Ola Helm <ola.hel@gmail.com> wrote:
>
> =20
>
>>Hi,
>>
>>Have you got some idea what's the situation of the 24xx camera driver
>>at the
>>moment? AFAIK the patch David sent in last month is not included to
>>tree,
>>propably since there were some opposite opinions about the way of
>>implementation and at least I did not have one file mentioned in
>>patch (I
>>think you mentioned about the same issue)
>>   =20
>>
>
>24xx camera driver is now in David's hand. I just review the code now,
>as not able to work on camera stuff anymore.
>=20
>Following strategy can work out meanwhile as I had offline discussion
>with David :)
>
>o Separate 24xx CamDMA code from omap24xxcam.c to new file as=20
>  exported apis (Suggested by David)
>
>o Keep the old omap24xxcam driver interface(2.6.8 TI kernel days),=20
>  having video out code part of the camera driver itself. As new=20
>  separated video out code depends upon the common display controller =20
>  library, which requires to change fb driver in git tree to adopt=20
>  that interface, so that video out, and fb driver can=20
>  utilize the same code. But video out patches submitted by me didn't=20
>  generated any discussion on the list in that direction.=20
>
>o So, to have 24xx camera code in git tree, we can use the old camera=20
>  driver interface as of now, if everyone agrees.
>
>---Komal Shah
>http://komalshah.blogspot.com/
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around=20
>http://mail.yahoo.com=20
> =20
>
