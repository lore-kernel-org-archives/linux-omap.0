From: Kavita Kalra <kavita.dsp@gmail.com>
Subject: Re: Booting problem !!
Date: Fri, 9 Dec 2005 11:52:13 +0530
Message-ID: <c474a93a0512082222t2ae164c2l4e64e7080a06d3e1@mail.gmail.com>
References: <20051208100142.13344.qmail@web50715.mail.yahoo.com>
	<7dc7802e0512080754h14a8d928g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7dc7802e0512080754h14a8d928g@mail.gmail.com>
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
To: nitesh ranjan <nit_ranjan@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi ....i hv just started working on omap5912.

And while trying to load the kernel image encountered the same
problem.Theprocessor hanged after i gave the command bootm...........I
had to reload
the uImage again . I am not sure whether it will help u or not but it may b=
e
becoz of the size of kernel that u entered may be different .In my case it
was this.
But i m struck at the same point once again........I am using the procedure
mentioned in the documentation that is provided with the kit but it says
minicom does not work properly with uboot.....i saw in your mail that u r
using minicom.........is it working fine?

Pls excuse me 4 my ignorance  but i m confused how to enter kernel
parameters .using hyperterminal........the command is
setenv bootargs console=3Dttys0,115200n8 noinitrd rw ip=3Ddhcp root=3D/dev/=
nfs
nfsroot=3Dserverip:/home/username/montavista/filesys,nolock mem=3D30M
saveenv
Is it jst a command to enter the parameters or it requires the linux system
ON at that particular moment?

if yes then hw to communicate with linux on one system and hyperterminal on
winxp of some other system..........does it require some configurational
setup ?Or should i configure minicom for this purpose......?
pls suggest ???




> 2005/12/8, nitesh ranjan <nit_ranjan@yahoo.com>:
> >
> >
> > when I connect osk5912 and start minicom..it does not
> > show anything..(earlier it was booting..)thr is no
> > power on the ethernet leds .Also..in windows after
> > connecting thr hypertrm .osk doesnot boot at all .
> > What I did was ..loading my fresh compiled kernel
> > uImage into osk5912..(version D)..an error has occured
> > ..an flash was not erased at some location ..and wht i
> > did.. I typed bootm ..then it loaded linux.. and after
> > entering ..it hanged ..then.. i pressed reset
> > button.Since then , thr is no booting ..at all
> > ..nothing is being shown .
> > Plz suggest wht to do and what had happened :(
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam protection around
> > http://mail.yahoo.com
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
