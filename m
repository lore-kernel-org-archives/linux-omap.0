From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: Re: problem with root filesystem
Date: Fri, 17 Mar 2006 15:32:44 +0530
Message-ID: <26d3a31c0603170202q68170beo98e12da3ad721cb2@mail.gmail.com>
References: <26d3a31c0603160656v26d05b0epc1b9c00286920cec@mail.gmail.com>
	<3d3153f60603170121ob1c86cana0906006fc151503@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60603170121ob1c86cana0906006fc151503@mail.gmail.com>
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
To: Ola Helm <ola.hel@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Helm,
i am getting this error
# mkdir adfadf
mkdir : Cannot Create Directory 'adfadf' : Read-only file system
--prafulla chandra



On 3/17/06, Ola Helm <ola.hel@gmail.com> wrote:
>
> Hi,
>
> What's the exact error code your system gives when you're trying to creat=
e
> the folder?
>
> Cheers,
>
> /O
>
>  On 3/16/06, prafulla chandra vejendla < v.prafulla@gmail.com> wrote:
>
> > Matthew,
>
> I have the your steps. I have set rw in boot args and my bootargs also
> looks
> like yours. And I have checked the access rights in the HOST and it has
> fulll access. But still the problem prevails. What could be the reason.
>
>
> G'Day,
>
> > i followed newbie guide and i mounted the root filesystem using the NFS=
.
> i
>
> > have given read/write access to that folder to all in the exports file
> .but
>
> > i am unable to create single directory in the target .why is it so ??
> how
> to
>
> > overcome this problem . i have down loaded the root filesystem from the
>
> > following website http://linux.omap.com/pub/filesystem/rootfsosk.tar.bz=
2
>
>
> There are a few possible causes of this, but the most likely is that
>
> you are mounting the filesystem as read-only; make sure you have `rw' in
>
> the `bootargs' environmental variable in u-boot. Here is what I set
>
> them to when using NFS:
>
> setenv bootargs console=3DttyS0,115200n8 noinitrd ip=3Don root=3D/dev/nfs=
 rw
>
> nfsroot=3D${MY_IP}:${PATH_TO_ROOTFS},nolock
>
> saveenv
>
> If that is not the problem, check the permissions as they are set on
>
> the host system: it is possible, however unlikely, that you have them
>
> set up in some strange way (eg -r-xr-xr-x).
>
> -- Matthew
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
