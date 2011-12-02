From: Sylwester Nawrocki <snjw23@gmail.com>
Subject: Re: [RFC PATCH v1 0/7] media&omap4: introduce face detection(FD)
 driver
Date: Fri, 02 Dec 2011 11:28:56 +0100
Message-ID: <4ED8A868.4020005@gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Ming,

On 12/02/2011 10:12 AM, Ming Lei wrote:
> Hi,
> 
> These v1 patches(against -next tree) introduce v4l2 based face
> detection(FD) device driver, and enable FD hardware[1] on omap4 SoC..
> The idea of implementing it on v4l2 is from from Alan Cox, Sylwester
> and Greg-Kh.
> 
> For verification purpose, I write one user space utility[2] to
> test the module and driver, follows its basic functions:
> 
> 	- detect faces in input grayscal picture(PGM raw, 320 by 240)
> 	- detect faces in input y8 format video stream
> 	- plot a rectangle to mark the detected faces, and save it as 
> 	another same format picture or video stream
> 
> Looks the performance of the module is not bad, see some detection
> results on the link[3][4].
> 
> Face detection can be used to implement some interesting applications
> (camera, face unlock, baby monitor, ...).
> 
> TODO:
> 	- implement FD setting interfaces with v4l2 controls or
> 	ext controls
> 
> thanks,
> --
> Ming Lei
> 
> [1], Ch9 of OMAP4 Technical Reference Manual
> [2], http://kernel.ubuntu.com/git?p=ming/fdif.git;a=shortlog;h=refs/heads/v4l2-fdif
> [3], http://kernel.ubuntu.com/~ming/dev/fdif/output
> [4], All pictures are taken from http://www.google.com/imghp
> and converted to pnm from jpeg format, only for test purpose.
> 

Could you please resend this series to Linux Media mailing list
(linux-media@vger.kernel.org) ? It touches V4L core code and I'm
sure other v4l2 developers will have some comments on it.
I'll try to review it on the weekend.

-- 

Thanks,
Sylwester
