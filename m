From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: new libv4l2 (was Re: [PATCH, libv4l]: Make libv4l2 usable on
 devices with complex pipeline)
Date: Mon, 30 Jul 2018 06:31:30 -0300
Message-ID: <20180730063122.73a20c55@coco.lan>
References: <20180708213258.GA18217@amd> <20180719205344.GA12098@amd>
 <20180723153649.73337c0f@coco.lan> <20180728211110.GB1152@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180728211110.GB1152@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mchehab@s-opensource.com, ivo.g.dimitrov.75@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, hans.verkuil@cisco.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?UTF-8?B?TWF0aWpldmnEhw==?= <filip.matijevic.pz@gmail.com>, sakari.ailus@iki.fi, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Em Sat, 28 Jul 2018 23:11:10 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> Hi!
> 
> > > > Add support for opening multiple devices in v4l2_open(), and for
> > > > mapping controls between devices.
> > > > 
> > > > This is necessary for complex devices, such as Nokia N900.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>    
> > > 
> > > Ping?
> > > 
> > > There's a lot of work to do on libv4l2... timely patch handling would
> > > be nice.  
> > 
> > As we're be start working at the new library in order to support
> > complex cameras, and I don't want to prevent you keeping doing your
> > work, IMHO the best way to keep doing it would be to create two
> > libv4l2 forks:  
> 
> BTW.. new library. Was there decision what langauge to use? I know C
> is obvious choice, but while working on libv4l2, I wished it would be
> Rust...
> 
> Rewriting same routine over and over, with slightly different types
> was not too much fun, and it looked like textbook example for
> generics...

Whatever language it uses, the library should provide a standard C API
interface and avoid using libraries that may not be available on
the systems supported by the v4l-utils package, as other packages
and a libv4l-compatible interface should be linked using it.

It should also be something that the existing v4l-utils developers are
familiar with. Right now, we have only C and C++ code inside v4l-utils.

So, I'd say that the language should be either C (the obvious choice)
or C++.

It should also be licensed using the same terms as v4l-utils libraries,
e. g. LGPL 2.1+.

Thanks,
Mauro
