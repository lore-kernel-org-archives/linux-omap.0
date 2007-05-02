From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Pending April patches
Date: Wed, 2 May 2007 15:16:00 +0530
Message-ID: <5d5443650705020246v3e4427b9t9290d3e18de4ff4b@mail.gmail.com>
References: <46374339.4030102@googlemail.com>
	<20070502084714.4a23397d.jarkko.nikula@nokia.com>
	<57314e840705012317m45e2d42y3120f2247393d8f7@mail.gmail.com>
	<5d5443650705020134n55148159i4d30a35b12695a66@mail.gmail.com>
	<57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com>
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
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/2/07, Budhee Jamaich <budheej@gmail.com> wrote:
> On 5/2/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> > On 5/2/07, Budhee Jamaich <budheej@gmail.com> wrote:
> > > Can you please explain me against what source tree you people are
> > > sending patches here ?
> > > is it one of these:
> > > http://linux.omap.com/pub/kernel/2430sdp/source/
> > > or is it this:
> > > http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=tree;h=52cbee1227465a23c586734fb1226276bfee877b;hb=52cbee1227465a23c586734fb1226276bfee877b
> >
> > It is the second one you have mentioned. OMAP Community works on GIT
> > tree available on source.mvista.com/git only and it is preferred that
> > patches to be generated against it for submission.
>
> Hmm ok. and is this source tree good for any OMAP ? 2430 too ?
>

It depends on what are the "good" things you are expecting from
particular OMAP support in this GIT tree. OMAP2430 core and TWL4030
support is included in GIT tree, and Syed is working on adding GPIO
and Keypad driver.

You can help by porting the drivers/support you want to see in latest
kernel by porting them from TI's kernel tarballs.

-- 
--Trilok Soni
