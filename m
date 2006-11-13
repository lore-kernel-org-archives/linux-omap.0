From: "Chung-Wei Ruan" <cwruan@gmail.com>
Subject: Re: problem on tlv320aic23 in osk5912 using dspgateway3.3
Date: Mon, 13 Nov 2006 22:50:16 +0800
Message-ID: <34d819150611130650v5066fb33t15174e6ff0fceed2@mail.gmail.com>
References: <34d819150611110316w68ade769obe58b280fc9c10f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <34d819150611110316w68ade769obe58b280fc9c10f7@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello

I use similar way to implement the audio echo application according to the
TI's document with SIO and aic23 by dsp gateway. I got the same problem with
you.
By my tracing, I found the SIO_reclaim function would block and the program
would hang there. I know the SIO_reclaim is bolcking function. But I don't
understand why it blocks there. I traced the RF6 application example which
is provided by TI, and I think my basic setting (about the SIO and device
driver) is the same with that except that I don't use the TSK as the RF6 and
I use the dsp gateway (not dsp/bios link). I use the same program flow as
you. I have found some documents and it seems that the SIO application must
be used as TSK (I amd not sure). I tried many methods, but I can't succeed
to use TSK in the dsp gateway. Have you solved this problem?
Do anybody know about this issue?
Can SIO be used in the dsp gateway?
Thank you very much!!

B.R.
C.W.



> Hi all:
>      i want to use dspgateway3.3(kernel2.6.12) to develop a
> application,which sample some data through  tlv320aic23 in osk5912 dsp
> side, then sent data to arm for process using dspgateway3.3.
> for test, i sample some mp3 data played in pc,and sent it to tlv320aic23
to
> replay in dsp side (using SIO stream to iuuse full buffer data). but no
> sound output in headphone port!!why??


snipped...


> static Uns tfad_adctask_rcv_wdsnd(struct dsptask *task, Uns cmd)
> {
> int nmadus, i;
> unsigned short * inbuf;
> unsigned short * outbuf;
>
>    for (;;)
>    {
>       // if ( SIO_ready(instream) )
>       {
>          /* Reclaim full buffer from the input stream */
>        if ((nmadus = SIO_reclaim(instream, (Ptr *)&inbuf, NULL)) < 0)
>        {
>            dbg(task,"Error reclaiming full buffer from the input
> stream\n");
>      }
>        if (SIO_reclaim(outstream, (Ptr *)&outbuf, NULL) < 0)
>        {
>           dbg(task,"Error reclaiming empty buffer from the output
> stream");
>           }
>
>           /* Do the data move. */
>          for (i = 0; i < (nmadus / sizeof(short)); i++)
>           {
>             outbuf[i] = inbuf[i];
>           }
>
>     /* Issue full buffer to the output stream */
>           if (SIO_issue(outstream, outbuf, nmadus, NULL) != SYS_OK)
>           {
>             dbg(task,"Error issuing full buffer to the output stream");
>           }
>
>          /* Issue an empty buffer to the input stream */
>          if (SIO_issue(instream, inbuf, SIO_bufsize(instream), NULL) !=
>SYS_OK)
>          {
>         dbg(task,"Error issuing empty buffer to the input stream\n");
>          }
>     }
>    }
>
>    return 0;
>
> }
>
>
> when run the task, why no sound heard in the headphone port!?
>
> Please provide solutions for my queries.
>
>Thanks in advance,
>lam
