From: "Walden, Ralph" <Ralph.Walden@stryker.com>
Subject: RE: how to integrate application with dsplink
Date: Tue, 18 Sep 2007 10:27:04 -0400
Message-ID: <BADAD3D07EB6FD44BFB637D09C48205006D187B0@KZOMAIL.corp.strykercorp.com>
References: <20070916170002.2B7408062A@linux.omap.com>
	<BADAD3D07EB6FD44BFB637D09C48205006D187A7@KZOMAIL.corp.strykercorp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>Date: Sat, 15 Sep 2007 23:56:44 -0700 (PDT)
>From: sudip midya <sudip06@yahoo.com>
>Subject: how to integrate application with dsplink
>To: linux-omap-open-source@linux.omap.com
>Message-ID: <372249.22863.qm@web33101.mail.mud.yahoo.com>
Content-Type: text/plain; charset=3Dus-ascii

>Hi,
>   I am using dsplink for the first time. I have an application which
> genarates data sometimes which I have to
> transfer via dsplink(arm-dsp). I want to know that how to integrate my =
application with
> dsplink...the examples show standalone applications. How to have the =
build setup
> so that i can build my application along with the dsplink part?

You need to link with the dsplink.lib library.  You should then be able =
to use the dsplink API just like the examples.  Compile your DSP code =
with Code Composer, then make the binary available to the ARM =
application for loading to the DSP at run-time.

> Also, I have observerd that when I run the examples, it takes some =
time to get
> the startoff..maybe the PROC_load
> takes some time....can anybody confirm or if not, what takes a little =
time?

> Thanks and Regards,
> Sudip

It takes a little bit of time to setup the DSP and load the DSP code.  =
Are you observing this with one of the examples?  How long is it taking =
for you?=20


Ralph Walden





This email, including attachments, may include confidential and/or propri=
etary information, and may be used only by the person or entity to which =
it is addressed. If the reader of this email is not the intended recipien=
t or their authorized agent, the reader is hereby notified that any disse=
mination, distribution or copying of this e-mail is prohibited. If you ha=
ve received this email in error, please notify the sender by replying to =
this message and deleting the email immediately.
=0D
