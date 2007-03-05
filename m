From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Pending February (March) patches
Date: Mon, 5 Mar 2007 11:08:37 +0530
Message-ID: <5d5443650703042138m4239f210m1339267f12e08396@mail.gmail.com>
References: <45EB004C.40403@googlemail.com> <85irdgda6d.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <85irdgda6d.fsf@orfeo.duckcorp.org>
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
To: Rtp Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/5/07, Rtp Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Dirk Behme <dirk.behme@googlemail.com> writes:
>
> > Hi,
>
> Hi !
>
> >
> > please find below my list of pending OMAP patches for January 2007
> > (and from March up to now). As ususal, if you think anything is wrong,
> > missing or already applied, please correct. Especially if I lost the
> > track for N800, mainly the camera patches, forgive me and correct ;)
>
> I'll be again the evil guy but shouldn't the camera and radio patches be
> sent to the video4linux guys and the arm parts sent to Russel King ?
> imho the tree has already too much diverged from mainline to add some
> more drivers.
>

True. But most of the core support still left to be integrated in
mainline tree, on which it depends. Like gpio-expander issue, IrDA
driver was one such example by Komal. Only thing we can do right now
in mailing list for such drivers is to review and test on different
configurations, like OMAP2 camera driver with H4, N800, 2430 and
different sensors, this will shake out different bugs before we go for
upstream.

For Radio driver, it looks fine to me, and I will probably start
submitting it to v4l2 linux mailing list.

-- 
--Trilok Soni
