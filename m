From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: I2C zero length transfers and SMBUS_QUICK,
	was: Pending October patches
Date: Sun, 5 Nov 2006 11:49:15 -0800 (PST)
Message-ID: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com>
References: <454DBDC7.70706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <454DBDC7.70706@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Dirk Behme <dirk.behme@googlemail.com> wrote:


> >>Komal, what do you think here?
> >>
> >>Anybody aware of someone working on a better solution? Any 
> >>link to the LKML discussion about this?
> >>
> > Few links:
> ...
> >
>
http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001332.html
> 
> Sounds to me a clean fix (new I2C stack?) will need some 
> decades, if it comes at all. So, how to go one here?
> 
> Our hack to make things work on OMAP will not be accepted 
> upstream. But staying with broken OMAP features only because 
> (available) hack isn't acceptable in mainline doesn't sound 
> like an option as well.
> 
> I personally vote for working OMAP ;)
> 

Yes, we need working OMAPs and I don't know if it already broke n770
too. Let's see what Tony thinks about maintaining this fix in OMAP tree.

---Komal Shah
http://komalshah.blogspot.com/


 
____________________________________________________________________________________
Cheap Talk? Check out Yahoo! Messenger's low PC-to-Phone call rates 
(http://voice.yahoo.com)
