From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: v4l2_device/v4l2_subdev: please review
Date: Tue, 25 Nov 2008 08:10:01 +0100
Message-ID: <200811250810.01767.hverkuil@xs4all.nl>
References: <200811242309.37489.hverkuil@xs4all.nl>
	<5d5443650811242251g5ddda028q9413b0ff47fc08a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <5d5443650811242251g5ddda028q9413b0ff47fc08a8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 November 2008 07:51:25 Trilok Soni wrote:
> Hi Hans,
>
> On Tue, Nov 25, 2008 at 3:39 AM, Hans Verkuil <hverkuil@xs4all.nl> 
wrote:
> > Hi all,
> >
> > I've finally tracked down the last oops so I could make a new tree
> > with all the latest changes.
>
> Please send these patches to mailing list (git-send-email?) for easy
> review. Also CCing LKML for wider view is also good, as we are doing
> some core changes right?

I'm not going to spam the list with these quite big patches. Just go to 
http://linuxtv.org/hg/~hverkuil/v4l-dvb-ng/ and click on the 'raw' link 
after each change to see the patch. Most of these changes are just 
boring i2c driver conversions.

We are adding to the v4l core, but the changes do not affect existing 
v4l drivers let alone other subsystems. Although I should probably have 
added the omap list.

Regards,

	Hans

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
