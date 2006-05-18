From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Problem with play in O_RDWR mode on OMAP5912 OSK board
Date: Thu, 18 May 2006 12:07:45 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E071DB5@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ruchir.gulati@tcs.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ruchir,
> I have seen sevral posts whixh say that simultaneous read/write is
rather
> not do-able....
Not true - this is very well possible.
> "omap_audio: received DMA IRQ for non existent buffers!"
Looks like a serious buffer management problem to me.

I went in for one more iteration of the OSS audio driver here (inhouse)
while working on OMAP2430. This involves introduction of a new concepts:
1. DMA - static and dynamic chaining support
2. Mcbsp driver - does chained transfers
3. enhanced power management support.
With this I am able to do full duplex and half duplex support on
twl4030(http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?templat
eId=3D6123&contentId=3D4634&DCMP=3DWTBU&HQS=3DProductBulletin+OT+twl4030)=
 and
tsc2101 for 2430SDP. You can find an open version here:
http://linux.omap.com/pub/kernel/2430sdp/=20

However, much of this requires major sync up with the git kernel. I am
hoping to find some time in the coming few months to be able to push
that in.
> Does any of you have any ideas as to how things can be fixed?  If not
then
> I might have to start with ALSA.
For immediate requirement this might be a good idea to shift through
considering the future..

> message and/or attachments to it may contain
> confidential or privileged information. If you are
Finally,
Please check your copyright tag you add to an opensource list.. it is
frowned up as bad opensource etiquette.


Regards,
Nishanth Menon
