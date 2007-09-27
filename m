From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Real-Time
Date: Thu, 27 Sep 2007 16:22:06 +0200
Message-ID: <46FBBC8E.10209@googlemail.com>
References: <ae36f8040709261503s682feab2sdafd9643b9e0ecd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040709261503s682feab2sdafd9643b9e0ecd0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Cargnini wrote:
> Dear fellows,
> I',m developing some features in kernel has 12 months, and one of them =
are
> real-time scheduling with preemptive kernel, it is the Ingo Molnar patc=
hs,
> after been applied the patch this feature could be enabled or disabled
> during configuration.=20

What do you need to change on top of -rt? Last time I tried -rt worked=20
quite well with only small OMAP specific modifications.

> Could I submitt my modifications of Real-time kernel
> to the list for officially been included in the main source tree.

Patches that fix/modify/add stuff on top of -rt patch [1] have to go=20
to LKML with CC to Ingo Molnar, Thomas Gleixner and=20
linux-rt-users@vger.kernel.org. See

http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Sending_patch=
es
http://rt.wiki.kernel.org/index.php/Mailinglists

If patches are OMAP related a CC to this list (omap open source) would=20
be nice as well.

Best regards

Dirk

[1] http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
