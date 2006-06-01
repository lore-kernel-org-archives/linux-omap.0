From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: booting process
Date: Thu, 1 Jun 2006 12:25:12 -0300
Message-ID: <ae36f8040606010825g46a1ba8t34d9ae63c4a5c159@mail.gmail.com>
References: <14ACE099F888004586603AEC0A559C2E133FAE@DLEE09.ent.ti.com>
	<fbdfd0c30605312232j79263dfcq4cd3ee235508541e@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fbdfd0c30605312232j79263dfcq4cd3ee235508541e@mail.gmail.com>
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
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

thanks all for the ASAP answers, now seesm working no error  reported
any more using new mtd-tools, but stopped in this
IXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"...  done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspxor_ck"
Skipping reset check for DSP domain clock "dspper_ck"
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 108K

and do  not boot nothing else, i putted the busybox inside the image.
but i think this is a new subject.


On 6/1/06, J Yeh <jasonyeh0908@gmail.com> wrote:
> Were you able to mount /dev/mtdblock4 while using nfs as root file system=
?
>
> Jason
>
>


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
