From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Common code for TSC 2101 and 2102
Date: Fri, 13 Jul 2007 12:16:26 +0530
Message-ID: <5d5443650707122346n5d9e6fcfyfb3bb0fc2df54d57@mail.gmail.com>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

On 6/4/07, andrzej zaborowski <balrogg@gmail.com> wrote:
> Hi,
>   here's a proposition of a common driver for TSC 2101 and 2102 based
> on the previous 2102 code - the difference between the two chips'
> registers turns out to be minimal, not considering the audio part.
> 2101 provides a superset of 2102 functionality for the most part.

Anybody on list who can review this approach. We need to get this
thing sorted out and have alsa-audio ASoC support on 2420 H4 and
finally in mainline.

>
> I will appreciate if anyone with a board using a TSC2101 could test
> how this works for them, and even more if they can fix the parts that
> possibly don't work. The part that needs to go into the board file is
> similar to that in arch/arm/mach-omap1/board-palmte.c. Audio is not
> expected to work, but touchscreen and hwmon parts work for me.

I will try to review this patch, and not sure when I can test it
touchscreen part on H4.


-- 
--Trilok Soni
