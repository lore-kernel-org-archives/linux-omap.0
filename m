From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Bridge vs DSP/BIOS Link
Date: Wed, 16 May 2007 09:55:38 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429FD0A30@dlee13.ent.ti.com>
References: <8f4c83bc0705160632l288fdbdcibdbef525f75c97a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8f4c83bc0705160632l288fdbdcibdbef525f75c97a0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Josh Ostrander <jostrand@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Curious if anyone knows what the difference is between the=20
> DSPBridge OMAP DSP driver and the DSP/BIOS Link driver.  I=20
> did see a question posted about a year ago on this mailing=20
> list but sadly there was no response.  This is what I know:

Well a complete answer is to much to write and I wouldn't do it justice
as I don't know the whole picture.  But in short:

Give OMAPs ARM+DSP/s architecture TI has done reference implementations
of bridge and link for the major operating systems as required by
demand.

Bridge came first.  The bridge framework and associated pieces go up
high into an OS and do some media management aspects.  There are bridge
pieces on the ARM side and the DSP side (in addition to DSP BIOS).  The
sum of this is a large and complex package aimed at rich multimedia,
codec's and the like all fall in here as well.  If you look at
http://www.khronos.org/ you get the idea of what gets logically bundled
with full solution (OpenMax, ...).

For some customers bridge and upper related layers were to much given
their needs.  For these customers a "link" was created it does many of
the lower layers of the bridge function.  It doesn't try and integrate
as high up and doesn't provide the same level of features.

For Linux reference bridges do exist and they have evolved over time.
Customers have used this either directly or as a reference in
implementations of their own bridges.  Links also do exist for Linux.
If you look inside products you likely will find a few different ones
about.  At the bottom they are similar as you go up and they integrate
in to multimedia they diverge.

The low layer concepts between the bridges are similar.  The use of
mailbox hardware to exchange messages, idea of a DSP at the other end
likely running DSP BIOS, DSP-MMU usage, you need to
init/load/create&control-xmit-recv-data-streams.  Across OMAP1-2-3 the
DSP block's capabilities have been going up.  So you find the upper
layers of the bridge growing.

Nokia did contribute their version of bridge/link a couple years back
(dspgateway).  This is used in their 770 and 800 products.

Hope that helps.

Regards,
Richard W.
