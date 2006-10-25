From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: A problem about tsc2101 omap audio alsa driver on H3 board
Date: Thu, 26 Oct 2006 02:29:56 +0300
Message-ID: <453FF374.9050300@cc.jyu.fi>
References: <A091501C5752EE42A2FD8880B8EF192F3F87C0@njgex02.njg.access-company.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <A091501C5752EE42A2FD8880B8EF192F3F87C0@njgex02.njg.access-company.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?GB2312?B?TmluZ3pob25nIE1pYW8gLSDD58T+1tI=?= <Ningzhong.Miao@access-company.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> The program died here, and earphone don=A1=AFt have any sound.
>
> I have tried oss audio driver and 2.6.17 kernel. They are same.
>  =20
Hmm, aplayer has newer crashed for me.
Could you first try to change the playback target from speaker (default)
to headphone by using alsa-mixer to check whether you can then hear
something? If crash still happens, could you try to remove debug,
change again the target to headphone with alsa-mixer and try again with
aplay.

Mika
