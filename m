From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: SD response type 6 vs. 1
Date: Wed, 06 Jun 2007 20:09:12 +0200
Message-ID: <4666F848.1020600@drzeus.cx>
References: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
	<466456CC.1070408@drzeus.cx> <4664607B.1070103@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4664607B.1070103@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> Regarding the correct fix mentioned (and discussed) by Pierre, I'd
> implemented a piece of this fix by removing CERR, but it's not enough to
> make SD works. The patch find attached to this mail.
>
>   

I suspect you can't just ignore it. You should probably treat it as if
the command completed correctly (as END_OF_CMD I suppose).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
