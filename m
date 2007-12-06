From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: LCD Backlight control
Date: Thu, 6 Dec 2007 01:21:33 +0100
Message-ID: <fb249edb0712051621kda8526cm9512099d9b545fad@mail.gmail.com>
References: <E1067FCAA4D74F4DB1DD9FBA2CE84A97B93FD5@dnce04.ent.ti.com>
	<200712051324.26035.david-b@pacbell.net>
	<fb249edb0712051334i21905eb5q428f8da7825fc9b3@mail.gmail.com>
	<200712051457.13767.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200712051457.13767.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: "Agarwal, Vivek" <vagarwal@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 05/12/2007, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 05 December 2007, andrzej zaborowski wrote:
> > On 05/12/2007, David Brownell <david-b@pacbell.net> wrote:
>
> > > (I don't know any reason that driver shouldn't go upstream, BTW;
> > > most other OSK support is already there.)
> >
> > Yes, it would be very nice if it could make its way there. It's a tiny
> > piece but it so far is the driver that broke perhaps most often in
> > this whole tree, due to backlight fwk changes upstream having to be
> > accounted for on merges.
>
> How's this look?  Against recent upstream GIT, verified on OSK+Mistral.

Thanks, that's exactly how it should look I guess. Verified also on
Palm T|E (omap git + drivers/video/backlight/ from linus git + this
patch).

> I'm assuming that the OMAP2 support was a mistake ... is that right?

I wasn't sure but now I see that there's even no PWL registers there.

> If it looks right, feel free to sign off and submit this as-is.

So I will, thanks again. Will only change the omap_bl.c to omap1_bl.c
in the file's header also.
Cheers
