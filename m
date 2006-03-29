From: toshihiro.kobayashi@nokia.com
Subject: Re: DSP Gateway Problem
Date: Thu, 30 Mar 2006 01:38:51 +0900 (JST)
Message-ID: <20060330.013851.730553329.toshihiro.kobayashi@nokia.com>
References: <7e6cc7550603290530s4313c15fn93433526166e5a62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7e6cc7550603290530s4313c15fn93433526166e5a62@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nagubk82@gmail.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: "naga rajan" <nagubk82@gmail.com>
Subject: DSP Gateway Problem
Date: Wed, 29 Mar 2006 19:00:22 +0530

> With reference to your mail, I patched the kernel 2.6.12 with "
> patch-2.6.12-omap1" from www.muru.com and "patch-2.6.12-omap1-dspgw3.3" from
> sourceforge.net for DSP gateway. I built the kernel image and mounted the
> filesystem with demo programs for dspgateway3.3. While executing the
> demo_console.out, I am getting the following error.
> #dspctl start demo_console.out

> *Unable to handle kernel paging request at virtual address e0010000*

It sounds like your chip has another ID than ones supported at that time,
i.e. the same issue with one discussed on this thread.
http://sourceforge.net/mailarchive/forum.php?thread_id=7790416&forum_id=33964

The solution is to use newer kernel or to add the support for your chip
in the kernel, as Olav has done.

BR,
Toshihiro Kobayashi
