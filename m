From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Can DSP Gateway be used with OMAP 730
Date: Tue, 3 Apr 2007 12:31:49 +0530
Message-ID: <61445c750704030001w222840d4hfc75f4e8eac151b2@mail.gmail.com>
References: <61445c750704012346r17b0e84r8e160994e390af05@mail.gmail.com>
	<61445c750704020134g738c9550j365621d2c3ddf0e5@mail.gmail.com>
	<20070402.152956.88622893.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070402.152956.88622893.Hiroshi.DOYU@nokia.com>
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
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 4/2/07, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: "ext Pharaoh ." <pharaoh137@gmail.com>
> Subject: Re: Can DSP Gateway be used with OMAP 730
> Date: Mon, 2 Apr 2007 14:04:43 +0530
>
> > On 4/2/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> > > Hello,
> > >
> > > I am working on a OMAP 730 based board. We are supposed to have a
> > > software module called CSMI (coprocessor shared memory interface)
> > > which is needed for communications between the ARM9EJS and the DBB
> > > part of OMAP 730. While googling I found DSP Gateway which is a smilar
> > > kind of mechanism. My question is, can this be used with OMAP 730?
> > > According to the website it does not support OMAP 730. Has anyone made
> > > it work for OMAP 730? Can this be modified to work with OMAP 730? Am I
> > > thinking in the right direction or it just a different thing
> > > altogether?
> > >
> > >
> > > -Pharaoh.
> > >
> >
> >
> > I think I have found the answer for my previous query, not sure
> > though. DSP Gateway can be used to communicate between the ARM core
> > and the DSP. For example in case of OMAP 1710 there is an ARM926 core
> > and a DSP, DSP gateway is used for communicating between them. In case
> > for OMAPs like OMAP 730 etc the arch is little bit different i.e. ARM
> > 926 is used as an application processor and on the DBB side there is
> > ARM 7 and a DSP.
>
> Though I don't have any information about OMAP730, if TI's DSP/BIOS
> runs on/supports DBB side and only C54x(not ARM7) is used to
> communicate with ARM926 through mailbox and shared memory, in that
> case, the difference may be not huge....
>



 Okay, now it is clear. DSP Gateway can not be used for OMAP 730. Since
 the arch is different and OMAP 9 doesn't directly communicate with the
 DSP, rather it communicates with ARM 7. So it is a different thing
 altogether. The communication mechanism and and protocol more or less
 is same i.e. using mailbox IPIs and shared memory.

 -Pharaoh.
