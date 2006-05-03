From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Wed, 03 May 2006 22:42:58 +0300
Message-ID: <445907C2.8050303@cc.jyu.fi>
References: <4452384E.7080409@gmail.com> <20060503125606.GG30376@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060503125606.GG30376@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>Thanks, pushed your patch.
>
>I think the earlier patch chunk has gotten auto-hosed by git merge in
>Juha's recent merge:
>
>http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=330c1eb9a689973326cdece277d0b4b409833bb9
>
>Mika & Dirk, can you guys check if some of the other audio files got
>hosed or some old audio files got added back?
>  
>
I think the sound/arm/omap-aic23.h has appeared as a resulf of that and
can be removed. The new version is nowadays in
sound/arm/omap/omap-alsa-aic23.h

Mika
