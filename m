From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Sun, 04 Mar 2007 11:42:02 +0100
Message-ID: <85649hjnnp.fsf@orfeo.duckcorp.org>
References: <45EA9F87.6090300@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45EA9F87.6090300@googlemail.com> (Dirk Behme's message of "Sun,
	04 Mar 2007 11:29:27 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

Hi,

> Update N800 defconfig, mainly to disable netfilter which
> doesn't compile:

Fixing the build may be a better idea than disabling it. (fyi, it's
enabled too in the n770 defconfig)

>
>    CC      net/ipv4/netfilter/ipt_IDLETIMER.o
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'utimer_work':
> net/ipv4/netfilter/ipt_IDLETIMER.c:80: error: 'struct
> net_device' has no member named 'class_dev'
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function
> 'utimer_notifier_call':
> net/ipv4/netfilter/ipt_IDLETIMER.c:187: error: 'struct
> net_device' has no member named 'class_dev'
> net/ipv4/netfilter/ipt_IDLETIMER.c:192: error: 'struct
> net_device' has no member named 'class_dev'
> net/ipv4/netfilter/ipt_IDLETIMER.c: At top level:
> net/ipv4/netfilter/ipt_IDLETIMER.c:276: warning:
> initialization from incompatible pointer type
> net/ipv4/netfilter/ipt_IDLETIMER.c:277: warning:
> initialization from incompatible pointer type
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'init':
> net/ipv4/netfilter/ipt_IDLETIMER.c:290: warning: implicit
> declaration of function 'ipt_register_target'
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'fini':
> net/ipv4/netfilter/ipt_IDLETIMER.c:300: warning: implicit
> declaration of function 'ipt_unregister_target'
>

This breakage is mainly due to : 
- iptables changes
- removal of class_dev in net_device

yesterday, I've made a patch for that but I only tested that it's
building. If you want to test it, ask and I'll send it.

Arnaud
