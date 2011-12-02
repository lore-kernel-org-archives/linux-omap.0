From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 0/7] media&omap4: introduce face detection(FD) driver
Date: Fri, 2 Dec 2011 22:59:10 +0800
Message-ID: <CACVXFVMCPWfThLkqA6Y5mLCAb76Vbw6COiKqE5vTPmFy=NavMw@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
	<4ED8A868.4020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ED8A868.4020005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 2, 2011 at 6:28 PM, Sylwester Nawrocki <snjw23@gmail.com> w=
rote:
> Hi Ming,
>
> On 12/02/2011 10:12 AM, Ming Lei wrote:
>> Hi,
>>
>> These v1 patches(against -next tree) introduce v4l2 based face
>> detection(FD) device driver, and enable FD hardware[1] on omap4 SoC.=
=2E
>> The idea of implementing it on v4l2 is from from Alan Cox, Sylwester
>> and Greg-Kh.
>>
>> For verification purpose, I write one user space utility[2] to
>> test the module and driver, follows its basic functions:
>>
>> =A0 =A0 =A0 - detect faces in input grayscal picture(PGM raw, 320 by=
 240)
>> =A0 =A0 =A0 - detect faces in input y8 format video stream
>> =A0 =A0 =A0 - plot a rectangle to mark the detected faces, and save =
it as
>> =A0 =A0 =A0 another same format picture or video stream
>>
>> Looks the performance of the module is not bad, see some detection
>> results on the link[3][4].
>>
>> Face detection can be used to implement some interesting application=
s
>> (camera, face unlock, baby monitor, ...).
>>
>> TODO:
>> =A0 =A0 =A0 - implement FD setting interfaces with v4l2 controls or
>> =A0 =A0 =A0 ext controls
>>
>> thanks,
>> --
>> Ming Lei
>>
>> [1], Ch9 of OMAP4 Technical Reference Manual
>> [2], http://kernel.ubuntu.com/git?p=3Dming/fdif.git;a=3Dshortlog;h=3D=
refs/heads/v4l2-fdif
>> [3], http://kernel.ubuntu.com/~ming/dev/fdif/output
>> [4], All pictures are taken from http://www.google.com/imghp
>> and converted to pnm from jpeg format, only for test purpose.
>>
>
> Could you please resend this series to Linux Media mailing list
> (linux-media@vger.kernel.org) ? It touches V4L core code and I'm

Yes, I will resend this series to linux-media mail list, thanks for poi=
nting
it out.  Of course, the most important mail list is missed for the patc=
hes,
very sorry about it.

thanks,
--
Ming Lei
