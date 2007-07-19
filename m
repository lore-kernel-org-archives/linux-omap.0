From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430 FB driver issues
Date: Thu, 19 Jul 2007 11:54:01 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47015D4AF9@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D9130274290176C1B0@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290176C1B0@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Hunyue Yau <hyau@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Not much useful information except that my guess is FB LCD is broken =
on
>> 2430SDP as of date and it is possibly broken from the time it is
>> enabled.. Since i do see Tony punching in a bunch every weekend, did
>> Hunyue test with the git latest once Tony finished pushing all =
patches?
>> - esp since May 25th is the time when the major clock/prcm  framework
>> patches from Paul W went into git.
>
>It is working now right?  I updated and booted my local version and all
>seems happy.
>
>I have a random patch or two differences from the stock kernel but I'm =
not
>sure they matter.
>

Some times it works with out any issues and few times it starts =
generating Sync Lost error. I was not getting this error for a week, but =
now even I notice these errors on same board :)

Regards,
Khasim
