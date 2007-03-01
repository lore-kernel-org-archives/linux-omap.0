From: tony@atomide.com
Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Thu, 1 Mar 2007 00:06:44 -0800
Message-ID: <20070301080643.GC26097@atomide.com>
References: <45E5A489.2040108@nokia.com>
	<9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
	<5d5443650702282148n4fd5f586te9d0814875f6b59c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650702282148n4fd5f586te9d0814875f6b59c@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070228 21:50]:
> Syed,
> 
> On 2/28/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> >If some patches are for review please mark them as "RFC". "Patch" is
> >when it has to go into tree - Some one can correct me if I am wrong.
> >
> >Sakari,
> >
> >Thanks for the code, do you have any kind of design doc or ppt that
> >gives a brief overview of what the code is and the interface considered
> >etc. Its bit hard to go directly to code :(
> 
> I don't think that you will need this. What interface you would like
> to understand? Please phrase the questions based on the code and may
> Sakari can help you to understand :) I believe some of the changes in
> N800 camera driver was also done to reduce the interrupt latencies and
> bugs in video-buf.

I agree with Trilok. The idea is to do incremental changes based on
patches.

> >The second issue is merging TI's camera code with this. I can post our
> >design considerations for camera. We can see how to integrate TIs sensor
> >and additional functionality provided by TI's camera code (like
> >rotation, scatter gather dma, multiple sensors handling etc).
> 
> Do you mean "rotation" of the preview window ? See, preview in camera
> driver is just a add-on functionality _but_ not must. I would not use
> this auto preview functionality, instead captured stream will go to
> /dev/fb1 and then shown on the LCD/TV out and rotated based on the
> N800 sensor or app commands.

Yyp, additional features are easy to add later once we have basics
in place.

Regards,

Tony
